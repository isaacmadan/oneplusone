class PairSetsController < ApplicationController

	def show
		@pair_set = PairSet.find_by_id(params[:id])
		@pairings = @pair_set.pairs.map{|x|x.members}
		@unpaired = Member.unpaired(@pairings)
	end

	def index
	end

	def create
		pairings = smart_fetch("all_pairings", :expires_in => 10.minutes) {
			Member.all.combination(2).to_a
		}

		puts pairings.map{|x|x.first.email_address + " : " + x.second.email_address}

		pairings = pairings.sort{|a,b|
				[b.first.pairs_with(b.second).size, (a.first.teams & a.second.teams).size] <=> [a.first.pairs_with(a.second).size, (b.first.teams & b.second.teams).size]
			}.reverse

		pairs = []
		pair_set = PairSet.new
		while pairs.size < Member.count/2
			pairings.each do |p|
				unless pairs.flatten.include?(p.first) || pairs.flatten.include?(p.second)
					pairs << p.to_a
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
			pair_set.delete
		end
		flash[:success] = "Pair set deleted."
		redirect_to root_path
	end

end
