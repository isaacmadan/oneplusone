class TeamsController < ApplicationController

	def new
		@team = Team.new
	end

	def create
		Rails.cache.clear
		team = Team.new(params[:team].permit!)
		team.save
		redirect_to members_path
	end

end
