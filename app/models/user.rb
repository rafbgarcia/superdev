class User < ApplicationRecord
  # Relationships
    has_many :discussions, dependent: :nullify
    has_many :answers, dependent: :destroy
    has_many :comments, dependent: :nullify
    has_many :notifications, -> { order(created_at: :desc) }

  # Devise
    devise :omniauthable, :omniauth_providers => [:facebook]
    devise :database_authenticatable, :recoverable, :rememberable,
           :validatable, :trackable

  # Callbacks
    before_save :set_name
    before_save :format_name_and_email


  # Paperclip
    has_attached_file :avatar, styles: { medium: "300x300#", small: "100x100#" }, path: "/users-images/:id-:style.:extension", default_url: 'default_avatar.png'
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  def first_name
    name.split(' ').first if name.present?
  end

  def current_avatar
    (avatar.exists? && avatar.url(:small)) || facebook_avatar || 'default_avatar.png'
  end

  def has_active_subscription?
    return false if self.iugu_subscription_expires_at.blank?
    self.iugu_subscription_expires_at > Date.today
  end

  def save_iugu_token!(token)
    self.update_attributes(iugu_token: token)
  end

  def activate_subscription!(subscription)
    return if self.has_active_subscription?

    new_password = Devise.friendly_token[0, 10]

    self.update!(
      iugu_subscription_id: subscription.id,
      iugu_subscription_expires_at: subscription.expires_at,
      password: new_password,
    )

    UserMailer.payment_approved(self, new_password).deliver_later
  end

  def create_customer_account
    customer = Iugu::Customer.create(
      name: self.name,
      email: self.email,
    )

    if !customer.errors
      self.update!(iugu_customer_id: customer.id)
    end

    customer
  end

  def client?
    self.iugu_subscription_id.present?
  end


# class methods

  def self.create_from_facebook(auth)
    existing_user = User.where(email: auth.info.email).first

    if existing_user
      existing_user.update({
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.name,
        gender: auth.info.gender,
        facebook_avatar: auth.info.image,
        facebook_link: auth.extra.raw_info.link,
      })
    else
      self.create!(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 10],
        name: auth.info.name,
        gender: auth.info.gender,
        facebook_avatar: auth.info.image,
        facebook_link: auth.extra.raw_info.link,
      )
    end
  end

  def self.from_name_and_email(params)
    user = where(email: params[:email]).first_or_initialize

    if user.new_record?
      user.name = params[:name]
      user.password = Devise.friendly_token[0, 10]
      user.save!
    end

    user
  end

  # def self.find_or_create_by(params)
  #   return if params.blank?
  #   user = User.where(email: params[:email].downcase).first_or_initialize

  #   if user.persisted?
  #     if !user.valid_password?(params[:password])
  #       user.errors.add(:password, 'Esta senha não confere com o e-mail')
  #     end
  #   else
  #     user.attributes = params
  #     user.save
  #   end

  #   user
  # end

  def self.from_customer_data(data)
    user = where(email: data[:email]).first_or_initialize

    if user.new_record?
      user.name = data[:name]
      user.password = Devise.friendly_token[0, 10]
      user.iugu_customer_id = data[:customer_id]
      user.save!(validate: false)
    end

    user
  end

  def self.activate_subscription!(subscription)
    user = User.where(iugu_customer_id: subscription.customer_id).first
    user.activate_subscription!(subscription)
  end

  def self.admin
    User.where(email: 'rafael@superdev.academy').first
  end

private

  def format_name_and_email
    self.name = self.name&.titleize
    self.email = self.email&.downcase
  end

  def set_name
    if self.name.blank?
      self.name = email.split('@').first
    end
  end

end
