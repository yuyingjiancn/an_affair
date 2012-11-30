# -*- coding: utf-8 -*-
class Manage::ExamPapersSingleChoicesController < ManageBaseController
  def create
    if request.xhr?
      begin
        ep = ExamPaper.where(:editable => true, :id => params[:eid]).first
        sc = SingleChoice.find(params[:qid])

        max_num = ExamPapersSingleChoices.where(:exam_paper_id => ep.id).maximum("order_num")
        logger.info("#"*100)
        if max_num
          order_num = max_num + 1
        else
          order_num = 1
        end
        logger.info("#"*100)
        logger.info(order_num)
        count = ExamPapersSingleChoices.where(:exam_paper_id => ep.id, :single_choice_id => sc.id).count
        raise "试卷中已经存在该题目" if count > 0

        epsc = ExamPapersSingleChoices.new(:exam_paper_id => ep.id, :single_choice_id => sc.id, :order_num => order_num)

        epsc.save
        render :json => { :success => true }

      rescue => err
        render :json => { :success => false, :message => err.to_s }
      end
    end
  end

  def list_by_exam
      @exam_paper = ExamPaper.find(params[:id])
      @epsc_list = ExamPapersSingleChoices.includes(:single_choice).where(:exam_paper_id => params[:id]).order("order_num ASC").all
  end

  def update_order_num
    if request.xhr?
      begin
        epsc = ExamPapersSingleChoices.find(params[:id])
        epsc.order_num = params[:order_num].to_i
        epsc.save
        render :json => { :success => true, :order_num => params[:order_num].to_i }
      rescue => err
        render :json => { :success => false, :message => err.to_s }
      end
    end
  end

  def destroy
    epsc = ExamPapersSingleChoices.find(params[:id])
    epsc.destroy
    redirect_to :action => "list_by_exam", :id => params[:eid]
  end

  def view_result
    @exam_paper = ExamPaper.find(params[:exam_id])
    epscs = ExamPapersSingleChoices.includes(:single_choice).where(:exam_paper_id => params[:exam_id]).all
    @right_answers = epscs.map { |epsc| { :epscId => epsc.id, :orderNum => epsc.order_num, :answer => epsc.single_choice.answer } }
    @school_class = SchoolClass.find(params[:school_class_id])
    @student_answers = ExamResult.includes(:student).where(:exam_paper_id => params[:exam_id],
                                                           :student_id => @school_class.students.map { |s| s.id }).all.map do |er|
      {:examResultId => er.id, :studentNumber => er.student.number, :studentName => er.student.name, :result => er.result }
    end
  end
end
