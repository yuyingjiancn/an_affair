class Student::PassportController < ForegroundBaseController

  skip_before_filter :need_login, :only => [:login]
  def login
    if request.get?
      redirect_to :controller => "/student/exam", :action => "list" unless session[:student].nil?
    elsif request.post?
      student = Student.where(:number => params[:number].downcase.strip).first
      if student.nil?
        flash[:error_number] = true
      else
        if student.password == params[:password].to_s.strip
          session[:student] = { :id => student.id,
                                :number =>student.number,
                                :name => student.name,
                                :school_class => student.school_class.name,
                                :school_class_id => student.school_class.id }
          redirect_to :controller => "/student/exam", :action => "list"
        else
          flash[:error_password] = true
        end
      end
    end
  end

  def logout
    session[:student] = nil unless session[:student].nil?
    redirect_to :action => "login"
  end
end
