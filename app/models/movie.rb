class Movie < ApplicationRecord
  belongs_to :client, optional: true

   # Validaciones
   validates :name, presence: true, length: { maximum: 200 }
  def to_s
    self.name
  end
end
