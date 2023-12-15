# Representa um autor no Biblivre
class AuthoritiesRecord < ApplicationRecord
  before_validation :set_user

  validates :iso2709, presence: true

  # Ultima criacao e edicao serao do usuario 1,
  # Que é o admin default do biblivre
  def set_user
    self.created_by = 1
    self.modified_by = 1
  end
end
