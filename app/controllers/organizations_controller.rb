class OrganizationsController < ApplicationController

	def new
		@organization = Organization.first
		unless @organization
			@organization = Organization.new
		else
			redirect_to edit_organization_path(@organization)
		end
	end

	def create
		org = Organization.new(params[:organization].permit!)
		unless org.save
			flash[:danger] = org.errors.empty? ? "Error" : org.errors.full_messages.to_sentence
			redirect_to :back
		else
			flash[:success] = "Organization created."
			redirect_to new_organization_path
		end
	end

	def edit
		@organization = Organization.first
	end

	def update
		org = Organization.first
		if org
			unless org.update_attributes(params[:organization].permit!)
				flash[:danger] = org.errors.empty? ? "Error" : org.errors.full_messages.to_sentence
				redirect_to :back
			else
				flash[:success] = "Organization updated."
				redirect_to edit_organization_path
			end
		else
			flash[:danger] = "Setup your organization first."
			redirect_to new_organization_path
		end
	end

end
