class EntriesController < ApplicationController	
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy
	def show
		@entry = Entry.find(params[:id])
		@user = @entry.user
		@comments = @entry.comments.paginate(page: params[:page])
		@comment = @entry.comments.build if signed_in?
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
			@feed_items = []
			render 'new'
		end
	end

	def destroy
		@entry.destroy
		redirect_to root_url
	end

	private

	def entry_params
		params.require(:entry).permit(:body,:title)
	end
	def correct_user
		@entry = current_user.entries.find_by(id: params[:id])
		redirect_to root_url if @entry.nil?
	end
end
