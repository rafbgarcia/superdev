class SubscriptionsController < ApplicationController

  def step_1
  end

  def step_2
    @step_2 = true
    if session[:user_id].present?
      redirect_to action: :new
    end
  end

  def create_customer
    @step_2 = true
    Iugu.api_key = ENV['IUGU_API_KEY'] || "30e045b8172796b804714c8423be3d9e"

    if customer_params.any? { |field_name, value| value.blank?}
      @errors = { '' => ['Por favor, preencha todos os campos'] }
      render :step_2
    else
      user_data = {
        name: customer_params[:name].titleize,
        email: customer_params[:email]
      }

      customer = Iugu::Customer.create(user_data)

      if customer.errors
        @errors = customer.errors # possibly "invalid email" error
        render :step_2
      else
        user = User.from_customer_data(user_data.merge(customer_id: customer.id))

        session[:user_id] = user.id
        redirect_to subscribe_path
      end
    end
  end

  def new
    if session[:user_id].blank?
      redirect_to action: :step_1
    end
    @step_3 = true
  end

  def create
    @step_3 = true
    Iugu.api_key = ENV['IUGU_API_KEY'] || "30e045b8172796b804714c8423be3d9e"

    if payable_with_credit_card?
      handle_credit_card
    else
      handle_bank_slip
    end
  end

  def complete
    redirect_to root_path if !user_signed_in?
  end

  def waiting_confirmation
  end

private

  def handle_credit_card
    user = User.find(session[:user_id])

    if user.iugu_token.blank?
      payment_method = Iugu::PaymentMethod.create({
        customer_id: user.iugu_customer_id,
        description: 'Cartão de Crédito',
        token: subscription_params[:token],
        set_as_default: true,
      })
    end

    @subscription = create_subscription_for(user)

    if @subscription.errors
      render 'new'
      return
    end

    invoice = @subscription.recent_invoices.first

    if invoice.present?
      user.save_iugu_token!(subscription_params[:token])

      if invoice['status'] == 'paid'
        user.activate_subscription!(@subscription)
        sign_in(user)

        redirect_to subscribed_path
      elsif invoice['status'] == 'pending'
        redirect_to subscription_waiting_confirmation_path
      end
    else
      render 'new'
    end
  end

  def handle_bank_slip
    user = User.find(session[:user_id])

    @subscription = create_subscription_for(user, payable_with: :bank_slip, expires_at: 1.day.from_now)
    invoice = @subscription.recent_invoices.first

    redirect_to invoice['secure_url']
  end

  def customer_params
    params.require(:new_customer).permit(:name, :email).to_h
  end

  def subscription_params
    params.permit(:token, :method)
  end

  def create_subscription_for(user, extra_data = {})
    data = extra_data.merge(
      customer_id: user.iugu_customer_id,
      plan_identifier: "superdev_academy_pioneiros",
    )

    if payable_with_credit_card?
      data[:only_on_charge_success] = true
    end

    Iugu::Subscription.create(data)
  end

  def payable_with_credit_card?
    subscription_params[:method] == "credit_card"
  end

end
