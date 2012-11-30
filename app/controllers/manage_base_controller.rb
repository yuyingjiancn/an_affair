# -*- coding: utf-8 -*-
class ManageBaseController < ApplicationController
  layout "manage_layout"

  before_filter :need_login

  protected
  def need_login
    if session[:manager].nil?
      redirect_to :controller => "/manage/passport", :action => "login"
      return
    else
      @manager = session[:manager]
    end
  end

  protected
  def swfupload_cookie_plugin
    session[:manager] = Marshal.load(Base64.decode64(params[:swfuploadCookie]))["manager"]
  end
end
