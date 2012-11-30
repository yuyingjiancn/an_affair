class ExamPaper < ActiveRecord::Base
  has_many :exam_papers_single_choiceses
  has_many :single_choices, :through => :exam_papers_single_choiceses
  attr_accessible :name, :editable
end
