# -*- coding: utf-8 -*-
class Manage::ExamResultsController < ManageBaseController
  def destroy
    if request.xhr?
      begin
        er = ExamResult.find(params[:id])
        er.destroy
        render :json => { :success => true }
      rescue => err
        render :json => { :success => false, :message => err.to_s }
      end

    end
  end
end
