class Student < ActiveRecord::Base
  belongs_to :school_class
  attr_accessible :name, :number, :password
end
