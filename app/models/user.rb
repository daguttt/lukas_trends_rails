class User < ApplicationRecord
  has_many :chats, dependent: :destroy

  # TODO: Add validations
end
