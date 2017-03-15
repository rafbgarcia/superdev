class SubscriptionsController < ApplicationController

  def step_1
  end

  def step_2
  end

  def create_customer
    Iugu.api_key = "30e045b8172796b804714c8423be3d9e"

    if customer_params.any? { |field_name, value| value.blank?}
      @errors = { 'Por favor' => 'preencha todos os campos'}
      render :step_2
    else
      customer = Iugu::Customer.create(customer_params)

      if customer.errors
        @errors = customer.errors
        render :step_2
      else
        session[:customer_id] = customer.id
        redirect_to subscribe_path
      end
    end
  end

  def new
    @customer_id = session[:customer_id]
  end

  def create
    Iugu.api_key = "30e045b8172796b804714c8423be3d9e"

    payment_method_key = (params[:token].empty? ? "method" : "token").to_sym

    customer = Iugu::Customer.create(params[:customer].to_h)

    subscription = Iugu::Subscription.create(
      payment_method_key => params[payment_method_key],
      plan_identifier: "superdev_academy_pioneiros",
      customer_id: customer.id,
    )


    if subscription && subscription.success
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

private

  def customer_params
    params.require(:new_customer).permit(:name, :email).to_h
  end

end
