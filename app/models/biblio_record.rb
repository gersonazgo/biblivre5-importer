# Representa o registro de uma obra no biblivre
class BiblioRecord < ApplicationRecord

  before_validation :set_material
  before_validation :set_user

  validates :iso2709, presence: true
  validates :iso2709, uniqueness: true

  # Todos os materiais que importarei serao
  # considerados livros
  def set_material
    self.material = 'book'
  end

  # Ultima criacao e edicao serao do usuario 1,
  # Que é o admin default do biblivre
  def set_user
    self.created_by = 1
    self.modified_by = 1
  end
end
