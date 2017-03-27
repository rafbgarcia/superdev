class NotificationsController < ApplicationController

  def redirect
    notification = Notification.find(params[:id])
    notification.mark_as_seen if !notification.seen?

    comment = notification.notificable
    discussion = comment.discussion

    redirect_to anchor_discussion_path(discussion)
  end

end
