class DiscussionsController < ApplicationController
  before_action :require_subscription
  before_action :set_item

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = current_user
    @discussion.item = @item

    if @discussion.save
      redirect_to anchor_discussion_path(@discussion)
    else
      render :new
    end
  end

  def edit
    @discussion = Discussion.friendly.find(params[:discussion_id])
  end

  def update
    @discussion = Discussion.friendly.find(params[:discussion_id])

    if @discussion.update(discussion_params)
      redirect_to anchor_discussion_path(@discussion)
    else
      render :edit
    end
  end

private

  def discussion_params
    params.require(:discussion).permit(:title, :text)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
