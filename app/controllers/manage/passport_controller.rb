class Manage::PassportController < ManageBaseController

  skip_before_filter :swfupload_cookie_plugin
  skip_before_filter :need_login, :only => [:login]
  def login
    if request.get?
      redirect_to :controller => "/manage/passport", :action => "index" unless session[:manager].nil?
    elsif request.post?
      manager = Manager.where(:account => params[:account].to_s.downcase.strip).first
      if manager.nil?
        flash[:error_account] = true
      else
        if manager.password == params[:password].to_s.strip
          session[:manager] = manager.account
          redirect_to :controller => "/manage/exam_papers", :action => "list"
        else
          flash[:error_password] = true
        end
      end
    end
  end

  def logout
    session[:manager] = nil unless session[:manager].nil?
    redirect_to :action => "login"
  end

  def index

  end
end
