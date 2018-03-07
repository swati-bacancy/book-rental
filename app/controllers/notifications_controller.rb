class NotificationsController < ApplicationController
  before_action :authenticate_person!
  def index
    @notifications=Notification.where(recipient: current_person).unread
  end
  def mark_as_read
    @notifications = Notification.where(recipient: current_person).unread 
    @notifications.update.all(read_at: Time.zone.now)
    render json: {success: true}
  end
end
