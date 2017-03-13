##
# This controller handles the CRUD for all types of items: Videos, Questions, etc
# The item type is passed on a query string param named :type
# e.g.
# GET /admin/videos/new?type=Video
# POST /admin/items?type=Video
##
class Admin::ItemsController < AdminController
    before_action :set_item, only: [:edit, :update, :destroy]

    def index
      @items = Item.by_lesson.includes(:itemable, lesson: :course).all
    end

    def new
      @itemable = itemable_class.new
    end

    def edit
    end

    def create
      @itemable = itemable_class.new(itemable_params)

      if @itemable.save!
        redirect_to admin_items_url, notice: 'item was successfully created.'
      else
        render :new
      end
    end

    def update
      if @itemable.update(itemable_params)
        redirect_to admin_items_url, notice: 'item was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @itemable.destroy!
      redirect_to admin_items_url, notice: 'item was successfully destroyed.'
    end

  private

    def set_item
      @itemable = itemable_class.find(params[:id])
    end

    def itemable_class
      @itemable_class ||= params[:type].constantize
    end

    def itemable_params
      params[params[:type].underscore.downcase.to_sym]
    end

end
