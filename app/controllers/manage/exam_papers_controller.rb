# -*- coding: utf-8 -*-
class Manage::ExamPapersController < ManageBaseController
  def create
    if request.get?
      @exam_paper = ExamPaper.new
    elsif request.post?
      ep = ExamPaper.new(params[:exam_paper])

      if ep.save
        flash[:success] = "已经生成了一张空白试卷"
        redirect_to :action => "list"
      end
    end
  end

  def edit
    @exam_paper = ExamPaper.find(params[:id])
  end

  def update
    @exam_paper = ExamPaper.find(params[:exam_paper][:id])
    @exam_paper.name = params[:exam_paper][:name]
    @exam_paper.editable = params[:exam_paper][:editable]
    if @exam_paper.save
      flash[:success] = "改名成功"
    else

    end
    render "edit"
  end

  def delete
    id = params[:id]
    ep = ExamPaper.find(id)
    if ep.nil?
      flash[:alert] = "id为#{id}的试卷不存在"
    else
      name = ep.name
      ep.destroy
      flash[:success] = "删除id是#{id}名为#{name}的试卷成功！"
    end
    redirect_to :action => :list
  end

  def list
    begin
      @eps = ExamPaper.paginate(:page => params[:page], :per_page => 10).order("id DESC")
    rescue => err
    end
  end
end
