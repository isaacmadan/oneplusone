class Team < ActiveRecord::Base

	has_and_belongs_to_many :members

	validates_presence_of :name
	validates :name, :uniqueness => true

end
