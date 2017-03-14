class SubscriptionsController < ApplicationController

  def new
    Iugu.api_key = 'AEF33427575F47A981F718E7A4BD9B80'
    @plans = Iugu::Plan.fetch
  end

  def create
    Iugu.api_key = "30e045b8172796b804714c8423be3d9e"

    payment_method_key = (params[:token].empty? ? "method" : "token").to_sym

    customer = Iugu::Customer.create(params[:customer].to_h)

    byebug

    subscription = Iugu::Subscription.create(
      payment_method_key => params[payment_method_key],
      plan_identifier: "superdev_academy_pioneiros",
      customer_id: customer.id,
    )


    if charge and charge.success
      render "new"
    else
      render "failed"
    end

  end

  def create_2
    Iugu.api_key = 'AEF33427575F47A981F718E7A4BD9B80'

    customer = Iugu::Customer.create(params[:customer].to_hash)

    subscription = Iugu::Subscription.create({
      plan_identifier: "superdev_academy_pioneiros",
      customer_id: customer.id,
    })
  end

end
