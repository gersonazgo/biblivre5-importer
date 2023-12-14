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

  def initialize(attributes = {})
    super(attributes)
    strip_special_characters
  end

  def strip_special_characters
    [:nro_tombo, :autor, :titulo].each do |attribute|
      value = self.send(attribute)
      next unless value.is_a?(String)

      # Remove caracteres especiais e espaços extras
      cleaned_value = value.gsub(/[^0-9a-zA-Z\s]/, '').strip
      self.send("#{attribute}=", cleaned_value)
    end
  end
end
