class Client < ApplicationRecord
  has_many :movies

  # Validaciones
  validates :name, presence: true, length: { maximum: 100 }
  validates :age, presence: true, length: { maximum: 2 }


  before_destroy :check_movies

  private

  def check_movies
    if movies.any?
      errors.add(:base, "No se puede eliminar el cliente porque tiene películas asignadas.")
      throw(:abort) # Detiene la eliminación
    end
  end
end
