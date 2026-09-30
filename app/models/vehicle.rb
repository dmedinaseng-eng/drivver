class Vehicle < ApplicationRecord
  belongs_to :user
  belongs_to :family, optional: true

  # Habilita múltiples imágenes adjuntas
  has_many_attached :images

  validates :plate, presence: true, uniqueness: { case_sensitive: false }
end
