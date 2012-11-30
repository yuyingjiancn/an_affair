# -*- coding: utf-8 -*-
class Manage::SingleChoicesController < ManageBaseController

  protect_from_forgery :except => [:image_upload]
  before_filter :swfupload_cookie_plugin, :only => [:image_upload]

  def create
    @swfupload_cookie = cookies["_an_affair_session"]
    if request.post?
      sc = SingleChoice.new(:content => params[:content],
                            :category_id => params[:ySelectedId],
                            :answer => params[:answer])
      if sc.save
        flash[:success] = "题目已经成功添加到题库中！"
        redirect_to :action => :list, :category_id => params[:ySelectedId]
      end
    end
  end

  def edit
    @swfupload_cookie = cookies["_an_affair_session"]
    @sc = SingleChoice.find(params[:id])
  end

  def update
    @swfupload_cookie = cookies["_an_affair_session"]

    @sc = SingleChoice.find(params[:single_choice][:id])
    @sc.content = params[:single_choice][:content]
    @sc.answer = params[:single_choice][:answer]
    @sc.category_id = params[:single_choice][:category_id]
    if @sc.save
      flash[:success] = "题目修改成功"
    else

    end
    render "edit"
  end

  def delete
    id = params[:id]
    sc = SingleChoice.find(id)
    if sc.nil?
      flash[:alert] = "id为#{id}的题目不存在"
    else
      sc.destroy
      flash[:success] = "删除id是#{id}的题目成功！"
    end
    redirect_to :action => :list, :category_id => params[:category_id]
  end

  def list
    begin
      @q_cate_id = Integer(params[:category_id])
      category = $question_categories.select { |c| c[:id] == @q_cate_id } .fetch(0)
      logger.info(category)
      if category.nil?
        @single_choices = Array.new
      else
        if category[:is_leaf]
          @single_choices = SingleChoice.where(:category_id => category[:id])
        else
          @single_choices = SingleChoice.where(:category_id => category[:leaf_ids])
        end
        @single_choices = @single_choices.paginate(:page => params[:page], :per_page => 10).order("id DESC")
      end
      @exam_papers = ExamPaper.where(:editable => true).all
    rescue => err
    end
  end


  def image_upload
    uimg = params[:picdata].original_filename
    uimg_ext = File.extname(uimg)

    respond_json = {}
    respond_json[:state] = "SUCCESS"

    if uimg_ext.downcase !~ /^\.(jpeg|jpg|png|bmp|gif)$/i
      respond_json[:state] = "上传图片格式不正确，只接受gif、jpg、bmp、png格式"
    end

    if params[:picdata].size > 1024 * 1024 * 5
      respond_json[:state] = "图片最大不能超过2M"
    end

    if respond_json[:state] == "SUCCESS"
      save_img_name = Time.now.strftime("%Y-%m-%d-%H-%M-%S") + uimg_ext
      uimg_save_path = Rails.root.to_s + "/public/upload_images/" + save_img_name
      uimg_save_url = "/upload_images/" + save_img_name
      File.open(uimg_save_path, "wb") { |f| f.write(params[:picdata].read) }
      respond_json[:url] = uimg_save_url
      respond_json[:title] = "no_title"
    end
    render :json => respond_json
  end
end
