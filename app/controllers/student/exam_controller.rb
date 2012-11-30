# -*- coding: utf-8 -*-
class Student::ExamController < ForegroundBaseController
  def list
    @exam_papers = ExamPaper.where(:editable => false).paginate(:page => params[:page], :per_page => 10).order("id DESC")
  end

  def do_it
    @exam_paper = ExamPaper.find(params[:id])
    @epscs = ExamPapersSingleChoices.includes(:single_choice).where(:exam_paper_id => params[:id]).order("order_num ASC").all
  end

  def submit_result
    if request.xhr?
      begin
      er_count = ExamResult.where(:exam_paper_id => params[:exam_paper_id],
                            :student_id => session[:student][:id]).count
      if er_count >0
        render :json => { :success => false, :message => "您已经做过该试卷，并提交了数据，不能重复提交。" }
        return
      end

      ExamResult.new(:result => params[:result],
                     :exam_paper_id => params[:exam_paper_id],
                     :student_id => session[:student][:id]).save
      epscs = ExamPapersSingleChoices.includes(:single_choice).where(:exam_paper_id => params[:exam_paper_id]).all
      answers = epscs.map { |epsc| { :epscId => epsc.id, :orderNum => epsc.order_num, :answer => epsc.single_choice.answer } }
      render :json => { :success => true, :answers => answers }

      rescue => err
        render :json => { :success => false, :message => err.to_s }
      end
    end
  end

  def student_result
    if request.xhr?
      begin
        er = ExamResult.where(:exam_paper_id => params[:exam_paper_id],
                         :student_id => session[:student][:id]).first
        if er
          epscs = ExamPapersSingleChoices.includes(:single_choice).where(:exam_paper_id => params[:exam_paper_id]).all
          right_answers = epscs.map { |epsc| { :epscId => epsc.id, :orderNum => epsc.order_num, :answer => epsc.single_choice.answer } }
          render :json => { :success => true, :done => true, :answers => er.result, :right_answers => right_answers }
        else
          render :json => { :success => true, :done => false }
        end
      rescue => err
        render :json => { :success => false, :message => err.to_s }
      end
    end
  end

  def view_result
    @exam_paper = ExamPaper.find(params[:id])
    epscs = ExamPapersSingleChoices.includes(:single_choice).where(:exam_paper_id => params[:id]).all
    @right_answers = epscs.map { |epsc| { :epscId => epsc.id, :orderNum => epsc.order_num, :answer => epsc.single_choice.answer } }
    @school_class = SchoolClass.find(session[:student][:school_class_id])
    @student_answers = ExamResult.includes(:student).where(:exam_paper_id => params[:id], :student_id => @school_class.students.map { |s| s.id }).all.map do |er|
      {:studentNumber => er.student.number, :studentName => er.student.name, :result => er.result }
    end
  end
end
