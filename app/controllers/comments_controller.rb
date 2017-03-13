class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.discussion = Discussion.friendly.find(params[:discussion_id])

    if @comment.save
      NotifyNewCommentOnDiscussionJob.perform_later(@comment.id)

      redirect_to discussion_path_form_params(anchor: "comment#{@comment.id}")
    else
      redirect_to discussion_path_form_params,
                  alert: "Não consegui salvar seu comentário devido a algum erro inesperado. Tentar comentar novamente por favor..."
    end
  end

private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def discussion_path_form_params(p = {})
    discussion_path(
      course_id: params[:course_id],
      lesson_id: params[:lesson_id],
      item_weight: params[:item_weight],
      discussion_id: params[:discussion_id],
      **p
    )
  end

end
