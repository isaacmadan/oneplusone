class Member < ActiveRecord::Base

	belongs_to :organization
	has_and_belongs_to_many :teams
	has_and_belongs_to_many :pairs

	validates :email_address, :uniqueness => true
    validates_format_of :email_address, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

    # returns array of members that this member shares at least one team with
	def teammates
		self.teams.map{|x|x.members}.flatten.select{|x|x!=self}.uniq
	end

	# returns array of unique members that this member has previously been paired with
	def previous_pairs
		self.pairs.map{|x|x.members}.flatten.select{|x|x!=self}.uniq
	end

	# returns array of size equal to number of times this member pairs with member supplied in parameter
	def pairs_with(member)
		self.pairs.map{|x|x.members}.flatten.select{|x|x == member && x!=self}
	end

	# array of members that are not paired in a given pair set
	def self.unpaired(pairings)
		Member.all - pairings.flatten
	end

end
