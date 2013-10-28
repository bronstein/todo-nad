class Todo < ActiveRecord::Base

	belongs_to :user
  attr_accessible :desc, :done, :dued, :title, :important
	validates :title, presence: true
	validates :important, :uniqueness => true, presence: true

end
