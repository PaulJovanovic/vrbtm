class NotificationsController < ApplicationController
  def read
    @notification = Notification.find(params[:id])

    if @notification.update_attributes(read: true)
      render json: {
        notification: {
          id: @notification.id,
          notifiable_type: @notification.notifiable_type,
          notifiable_id: @notification.notifiable_id,
          from_user_id: @notification.from_user_id,
          to_user_id: @notification.to_user_id,
          action: @notification.action,
          text: @notification.text,
          read: @notification.read,
          created_at: @notification.created_at
        }, status: :ok
      }
    else
      render json: { notification: { errors: @notifications.errors } }
    end
  end
end
