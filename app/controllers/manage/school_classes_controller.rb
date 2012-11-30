# -*- coding: utf-8 -*-
class Manage::SchoolClassesController < ManageBaseController
  def list_by_exam
    begin
      @school_classes = SchoolClass.all
    rescue => err

    end
  end
end
