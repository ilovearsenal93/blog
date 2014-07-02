class CommentsController < ApplicationController
  def index
  end
  def create  
    @comment = Comment.create(content:comment_params,user_id:current_user.id,entry_id:current_entry.id)
    if @comment.save
      redirect_to entry_path(current_entry)
    else
      render 'new'
    end
  end
  def new
  end
  def show
    @entries= current_entry.comments.all
  end
  def destroy
  end
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
  def correct_user
      @comment = current_user.comment.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
