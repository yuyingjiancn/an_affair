class ExamPapersSingleChoices < ActiveRecord::Base
  belongs_to :exam_paper
  belongs_to :single_choice
  attr_accessible :exam_paper, :exam_paper_id, :single_choice, :single_choice_id, :order_num
end
