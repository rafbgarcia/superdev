class User < ApplicationRecord
  # Relationships
    has_many :discussions, dependent: :nullify
    has_many :answers, dependent: :destroy
    has_many :comments, dependent: :nullify
    has_many :notifications, -> { order(created_at: :desc) }

  # Devise
    devise :omniauthable, :omniauth_providers => [:facebook]
    devise :database_authenticatable, :recoverable, :rememberable,
           :validatable, :registerable

  # Callbacks
    before_save :set_name
    before_save :format_name_and_email


  # Paperclip
    has_attached_file :avatar, path: "/users-images/:id-:style.:extension", default_url: 'default_avatar.png'
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  def first_name
    name.split(' ').first if name.present?
  end

  def current_avatar
    (avatar.exists? && avatar.url) || facebook_avatar || 'default_avatar.png'
  end


  def self.create_from_facebook(auth)
    self.create!(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      password: Devise.friendly_token[0, 10],
      name: auth.info.name,
      gender: auth.info.gender,
      facebook_avatar: auth.info.image,
      facebook_link: auth.extra.raw_info.link,
      guest: false,
    )
  end

  def self.from_customer_data(data)
    user = where(email: data[:email]).first_or_initialize

    if user.new_record?
      user.name = data[:name]
      user.iugu_customer_id = data[:customer_id]
      user.save!(validate: false)
    end

    user
  end

  def self.activate_subscription(subscription)
    User.where(customer_id: subscription.customer_id).update_attributes(
      has_active_subscription: true,
      iugu_subscription_id: subscription.id,
    )
  end

private

  def format_name_and_email
    self.name = self.name.titleize
    self.email = self.email.downcase
  end

  def set_name
    if self.name.blank?
      self.name = email.split('@').first
    end
  end

end
