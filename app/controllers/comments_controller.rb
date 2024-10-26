class CommentsController < ApplicationController
  before_action :find_event

  def create
    @comment = @event.comments.build(comment_params)
    if @comment.save
      redirect_to @event, notice: 'Comment was successfully created.'
    else
      render 'events/show'  # Render the event show page again if validation fails
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
