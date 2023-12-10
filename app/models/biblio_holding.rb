# Representa o registro de um exemplar de uma obra
# no Biblivre
class BiblioHolding < ApplicationRecord
  belongs_to :biblio_record, foreign_key: 'record_id'

  before_validation :set_material
  before_validation :set_user

  validates :iso2709, presence: true
  validates :iso2709, uniqueness: true

  # No de chamada
  validates :location_d, presence: true

  # Tombo patrimonial
  validates :accession_number, presence: true
  validates :accession_number, uniqueness: true

  # Ultima criacao e edicao serao do usuario 1,
  # Que é o admin default do biblivre
  def set_user
    self.created_by = 1
    self.modified_by = 1
  end

  # Todos os exemplares são holdings
  def set_material
    self.material = 'holdings'
  end
end
