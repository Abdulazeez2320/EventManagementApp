class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:rsvp, :cancel_rsvp]
  def index
    @events = Event.all
    @events = @events.where("title LIKE ? OR location LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
  end

  def rsvp
    if current_user.rsvp_to(@event)
      redirect_to @event, notice: 'RSVP successful.'
    else
      redirect_to @event, alert: 'Failed to RSVP.'
    end
  end

  def cancel_rsvp
    if current_user.cancel_rsvp_to(@event)
      redirect_to @event, notice: 'RSVP cancelled.'
    else
      redirect_to @event, alert: 'Failed to cancel RSVP.'
    end
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    @comments = @event.comments.order(created_at: :desc)
    @attendees = @event.rsvps
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :banner, :description, :location, :capacity, :date, :host)
  end
end
