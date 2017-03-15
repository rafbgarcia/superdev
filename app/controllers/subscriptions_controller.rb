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
      customer = Iugu::Customer.create({
        name: customer_params[:name].titleize,
        email: customer_params[:email]
      })

      if customer.errors
        # invalid email
        @errors = customer.errors
        render :step_2
      else
        session[:customer_id] = customer.id
        redirect_to subscribe_path
      end
    end
  end

  def new
  end

  def create
    Iugu.api_key = "30e045b8172796b804714c8423be3d9e"

    payable_with = (subscription_params[:method] == "credit_card" ? "credit_card" : "bank_slip")

    subscription_data = {
      payable_with: payable_with,
      plan_identifier: "superdev_academy_pioneiros",
      customer_id: session[:customer_id],
      expires_at: 1.day.from_now
    }

    if payable_with == 'bank_slip'
      @subscription = Iugu::Subscription.create(subscription_data)
      invoice = @subscription.recent_invoices.first

      redirect_to invoice['secure_url']

    else
      pay_method = Iugu::PaymentMethod.create({
        customer_id: session[:customer_id],
        description: 'Cartão de Crédito',
        token: subscription_params[:token],
        set_as_default: true,
      })

      subscription_data[:only_on_charge_success] = true

      @subscription = Iugu::Subscription.create(subscription_data)

      if @subscription.errors
        render 'new'
        return
      end

      invoice = @subscription.recent_invoices.first

      if invoice.present?
        if invoice['status'] == 'paid'
          redirect_to subscribed_path
        elsif invoice['status'] == 'pending'
          redirect_to subscription_waiting_confirmation_path
        end
      else
        render 'new'
      end
    end
  end

  def complete
  end

  def waiting_confirmation
  end

private

  def customer_params
    params.require(:new_customer).permit(:name, :email).to_h
  end

  def subscription_params
    params.permit(:token, :method)
  end

end
