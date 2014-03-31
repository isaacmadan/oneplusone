class PairSetsController < ApplicationController

	def show
		@pair_set = PairSet.find_by_id(params[:id])
		@pairings = @pair_set.pairs.map{|x|x.members}
		@unpaired = Member.unpaired(@pairings)
	end

	def index
		@pair_sets = PairSet.all.sort_by{|x|x.created_at}.reverse
	end

	def create
		# get all possible 1+1 pair combinations and store in cache
		pairings = smart_fetch("all_pairings", :expires_in => 30.minutes) {
			Member.all.combination(2).to_a
		}

		# sort these pair combinations by a) how often the two members have paired previously and b) how many teams they have in common
		pairings = pairings.sort{|a,b|
				[b.first.pairs_with(b.second).size, (a.first.teams & a.second.teams).size] <=> [a.first.pairs_with(a.second).size, (b.first.teams & b.second.teams).size]
			}.reverse

		pairs = []
		pair_set = PairSet.new
		while pairs.size < Member.count/2
			pairings.each do |p|
				unless pairs.flatten.include?(p.first) || pairs.flatten.include?(p.second)
					pairs << p.to_a # pick off optimal pairs from this list of pairings
					pair = Pair.new
					pair.members << p.first << p.second
					pair.save
					pair_set.pairs << pair
				end
			end
		end
		pair_set.save

		flash[:success] = "New pair set generated!"
		redirect_to members_path
	end

	def destroy
		pair_set = PairSet.find_by_id(params[:id])
		if pair_set
			pair_set.destroy
		end
		flash[:success] = "Pair set deleted."
		
		begin
			redirect_to :back
		rescue
			redirect_to root_path
		end
	end

end
