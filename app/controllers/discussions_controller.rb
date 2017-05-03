class DiscussionsController < ApplicationController
  before_action :require_subscription
  before_action :set_item
  before_action :set_discussion, only: [:edit, :update]
  before_action :check_discussion_user, only: [:edit, :update]

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
  end

  def update
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

  def set_discussion
    @discussion = Discussion.friendly.find(params[:discussion_id])
  end

  def check_discussion_user
    return if current_user.admin?

    if !@discussion.belongs_to?(current_user)
      redirect_to anchor_discussion_path(@discussion)
    end
  end

end
