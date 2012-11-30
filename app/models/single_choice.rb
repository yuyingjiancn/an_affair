class SingleChoice < ActiveRecord::Base
  has_many :exam_papers_single_choiceses
  has_many :exam_papers, :through => :exam_papers_single_choiceses
  attr_accessible :answer, :category_id, :content
end
