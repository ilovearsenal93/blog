class EntriesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	def show
	end
	def new
		if signed_in? 
		@entry = current_user.entries.build 
		else
			redirect_to signin_url, notice: "Please sign in."
		end
	end
	def create
		@entry = current_user.entries.build(entry_params)
		if @entry.save
			flash[:success] = "Entry created!"
			redirect_to root_url
		else
			render 'new'
		end
	end

	def destroy
	end

	private

	def entry_params
		params.require(:entry).permit(:body,:title)
	end
end
