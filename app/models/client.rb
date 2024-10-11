class Client < ApplicationRecord
  has_many :movies

  # Validaciones
  validates :name, presence: true, length: { maximum: 100 }
  validates :age, presence: true, length: { maximum: 2 }

end
