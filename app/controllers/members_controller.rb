class MembersController < ApplicationController

	def new
		@member = Member.new
		@teams = Team.all
		@members = Member.all
	end

	def create
		if params[:member]
			member = Member.new(params[:member].permit!)

			organization = Organization.find_by_id(params[:organization])
			member.organization = organization
			unless member.save
				flash[:danger] = member.errors.empty? ? "Error" : member.errors.full_messages.to_sentence
				redirect_to :back and return
			end

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
		redirect_to new_member_path
	end

	def index
		@pair_set = PairSet.last
		if @pair_set
			@pairings = @pair_set.pairs.map{|x|x.members}
			@unpaired = Member.unpaired(@pairings)
		end
	end

	def destroy
		if m=Member.find_by_id(params[:id])
			m.pairs.each do |p|
				p.delete
			end
			m.delete
			flash[:success] = "Member deleted."
			redirect_to new_member_path
		end
	end

end
