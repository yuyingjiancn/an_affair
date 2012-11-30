class ExamResult < ActiveRecord::Base
  belongs_to :exam_paper
  belongs_to :student
  attr_accessible :result, :exam_paper_id, :student_id
end
