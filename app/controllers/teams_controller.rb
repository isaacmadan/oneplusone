class TeamsController < ApplicationController

	def new
		@team = Team.new
		@teams = Team.all
	end

	def create
		Rails.cache.clear
		team = Team.new(params[:team].permit!)
		unless team.save
			flash[:danger] = team.errors.empty? ? "Error" : team.errors.full_messages.to_sentence
			redirect_to :back and return
		else
			flash[:success] = "Team created."
			redirect_to new_team_path
		end
	end

	def destroy
		if p=Team.find_by_id(params[:id])
			p.delete
			flash[:success] = "Team deleted."
			redirect_to new_team_path
		end
	end

end
