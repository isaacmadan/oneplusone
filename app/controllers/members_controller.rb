class MembersController < ApplicationController

	def new
		@member = Member.new
		@teams = Team.all
	end

	def create
		if params[:member]
			member = Member.new(params[:member].permit!)

			organization = Organization.find_by_id(params[:organization])
			member.organization = organization
			member.save

			if params[:teams]
				params[:teams].each do |k,v|
					if v
						t = Team.find_by_id(k.to_i)
						if t
							t.members << member
						end
					end
				end
			end
		end

		Rails.cache.clear
		flash[:success] = "New member created!"
		redirect_to members_path
	end

	def index
		@pair_set = PairSet.last
		if @pair_set
			@pairings = @pair_set.pairs.map{|x|x.members}
			@unpaired = Member.unpaired(@pairings)
			@pair_sets = PairSet.all.sort_by{|x|x.created_at}.reverse
		end
	end

end
