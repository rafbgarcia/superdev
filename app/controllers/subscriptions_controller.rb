class SubscriptionsController < ApplicationController

  def new
  end

  def create
    Iugu.api_key = "AEF33427575F47A981F718E7A4BD9B80"

    param = (params[:token].empty? ? "method" : "token").to_sym

    charge = Iugu::Charge.create({
      param => params[param],
      email: "rafbgarcia@gmail.com",
      items: [
        {
          description: "Item 1",
          quantity: "1",
          price_cents: "5990"
        },
        {
          description: "Item 2",
          quantity: "1",
          price_cents: "4000"
        }
      ]
    })

    if charge and charge.success
      render "thanks"
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
