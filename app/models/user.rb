class User < ApplicationRecord
  SUBSCRIPTION_TYPES = { FREE: 0, PREMIUM: 1 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :chats, dependent: :destroy

  enum :role, { USER: 0, ADMIN: 1 }
  enum :subscription_type, SUBSCRIPTION_TYPES

  before_create :set_default_role_and_subscription, if: :new_record?

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
    end
  end

  private

  def set_default_role_and_subscription
    self.role ||= :USER
    self.subscription_type ||= :FREE
  end
end
