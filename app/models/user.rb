class User < ApplicationRecord
  has_may :chats

  # TODO: Add validations
end
