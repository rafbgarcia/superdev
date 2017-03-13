class NotificationsController < ApplicationController

  def redirect
    notification = Notification.find(params[:id])
    notification.mark_as_seen if !notification.seen?

    comment = notification.notificable
    discussion = comment.discussion

    redirect_to discussion_path(
      discussion.item.lesson.course,
      discussion.item.lesson,
      discussion.item,
      discussion,
      anchor: "comment#{comment.id}",
    )
  end

end
