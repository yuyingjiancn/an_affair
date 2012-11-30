# -*- coding: utf-8 -*-
class ForegroundBaseController < ApplicationController
  layout "foreground_layout"

  before_filter :need_login

  protected
  def need_login
    if session[:student].nil?
      redirect_to :controller => "/manage/passport", :action => "login"
      return
    end
  end
end
