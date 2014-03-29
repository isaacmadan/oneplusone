class Member < ActiveRecord::Base

	belongs_to :organization
	has_and_belongs_to_many :teams
	has_and_belongs_to_many :pairs

	def teammates
		self.teams.map{|x|x.members}.flatten.select{|x|x!=self}.uniq
	end

	def previous_pairs
		self.pairs.map{|x|x.members}.flatten.select{|x|x!=self}.uniq
	end

	def pairs_with(member)
		self.pairs.map{|x|x.members}.flatten.select{|x|x == member && x!=self}
	end

	def self.all_pairings
		pairings = smart_fetch("all_pairings", nil) {
			Member.all.combination(2).sort{|a,b|
				[b.first.pairs_with(b.second).size, (a.first.teams & a.second.teams).size] <=> [a.first.pairs_with(a.second).size, (b.first.teams & b.second.teams).size]
			}.reverse
		}

		# pairings = Member.all.combination(2)
		# pairings = pairings.sort{|a,b|
		# 	[b.first.pairs_with(b.second).size, (a.first.teams & a.second.teams).size] <=> [a.first.pairs_with(a.second).size, (b.first.teams & b.second.teams).size]
		# }.reverse

		return pairings
	end

	# def self.current_pairings
	# 	pairings = self.all_pairings
	# 	pairs = []
	# 	pair_set = PairSet.new
	# 	while pairs.size < Member.count/2
	# 		pairings.each do |p|
	# 			unless pairs.flatten.include?(p.first) || pairs.flatten.include?(p.second)
	# 				pairs << p.to_a
	# 				pair = Pair.new
	# 				pair.members << p.first << p.second
	# 				pair.save
	# 				pair_set.pairs << pair
	# 			end
	# 		end
	# 	end
	# 	pair_set.save

	# 	return pairs
	# end

	def self.unpaired(pairings)
		Member.all - pairings.flatten
	end

end
