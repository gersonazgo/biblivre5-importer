# Representa uma linha do CSV, que equivale a
# um registro de Holding (exemplar) no banco de dados.
class Csv::Holding < ApplicationRecord
  attr_accessor :nro_tombo, :chamada, :autor, :titulo, :local, :est_pais, :editora, :ano, :obs, :conferencia
end
