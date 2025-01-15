class Currency < ApplicationRecord
  has_many :histories, dependent: :restrict_with_exception

  # TODO: Add validations
end
