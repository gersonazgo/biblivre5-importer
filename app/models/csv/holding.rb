require 'marc'

# Representa uma linha do CSV, que equivale a
# um registro de Holding (exemplar) no banco de dados.
class Csv::Holding

  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :nro_tombo, :local_chamada, :autor, :titulo, :local_cidade, :est_pais, :editora, :ano, :obs

  validates :nro_tombo, presence: true
  validates :autor, presence: true
  validates :titulo, presence: true
end
