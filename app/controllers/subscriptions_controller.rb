class SubscriptionsController < ApplicationController
  before_action :set_iugu_api_key

  def pioneiros
    @plan = PlanPresenter.new(Iugu::Plan.fetch_by_identifier('superdev_academy_pioneiros'))
    render :template
  end

  def partiu_codar
    @plan = PlanPresenter.new(Iugu::Plan.fetch_by_identifier('partiu_codar'))
    render :template
  end

  def create
    if customer_params.any? { |field_name, value| value.blank?}
      @errors = { '' => ['Por favor, preencha todos os campos'] }
    end

    user = User.from_name_and_email(customer_params)
    customer = user.create_customer_account

    if customer.errors
      @errors = customer.errors
      return render :template
    end

    if params[:method] == 'credit_card'
      customer.payment_methods.create({
        description: "Cartão de Crédito",
        token: subscription_params[:token],
        set_as_default: true
      })

      sub_params = {
        plan_identifier: 'partiu_codar',
        customer_id: customer.id,
        only_on_charge_success: true,
      }

      subscription = Iugu::Subscription.create(sub_params)

      if subscription.errors
        return render :template
      end

      user.save_iugu_token!(subscription_params[:token])

      invoice = subscription.recent_invoices.first

      if invoice['status'] == 'paid'
        user.activate_subscription!(subscription)
        sign_in(user)

        redirect_to subscribed_path
      elsif invoice['status'] == 'pending'
        redirect_to subscription_waiting_confirmation_path
      end
    else
      subscription = Iugu::Subscription.create(
        plan_identifier: 'partiu_codar',
        customer_id: customer.id,
        payable_with: :bank_slip,
        expires_at: 1.day.from_now,
      )

      invoice = subscription.recent_invoices.first

      redirect_to invoice['secure_url']
    end
  end

  def complete
    redirect_to root_path if !user_signed_in?
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

  def set_iugu_api_key
    Iugu.api_key = ENV['IUGU_API_KEY'] || "30e045b8172796b804714c8423be3d9e"
  end

end
