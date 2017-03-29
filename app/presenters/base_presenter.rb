class BasePresenter

  include FontAwesome::Sass::Rails::ViewHelpers
  include ApplicationHelper
  include ActionView::Helpers
  include ActionView::Context

  attr_accessor :object

  def initialize(object)
    @object = object
  end

  def method_missing(method_name, *args, &block)
    if @object.respond_to?(method_name)
      @object.send method_name
    else
      super method_name, *args, &block
    end
  end

end
