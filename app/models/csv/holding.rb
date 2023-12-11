require 'marc'

# Representa uma linha do CSV, que equivale a
# um registro de Holding (exemplar) no banco de dados.
class Csv::Holding

  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :nro_tombo, :local_chamada, :autor, :titulo, :local_cidade, :est_pais, :editora, :ano, :obs

  validates :nro_tombo, presence: true
  validates :local_chamada, presence: true
  validates :autor, presence: true
  validates :titulo, presence: true

  def to_marc
    raise 'Holding inválido' unless valid?

    record = MARC::Record.new

    # 2. Chamada/Localização - Campo de Controle (001)
    record.append(MARC::ControlField.new('001', chamada))

    # 3. Autor - Campo de Dados (100)
    record.append(MARC::DataField.new('100', '1', ' ', ['a', autor]))

    # 4. Título - Campo de Dados (245)
    record.append(MARC::DataField.new('245', '1', '0', ['a', titulo]))

    # 5. Local (Cidade) - Subcampo do Campo de Dados (260 $a)
    # 7. Editora - Subcampo do Campo de Dados (260 $b)
    # 8. Ano - Subcampo do Campo de Dados (260 $c)
    record.append(MARC::DataField.new('260', ' ', ' ', ['a', local], ['b', editora], ['c', ano]))

    # 6. Estado/País - Campo de Dados (264 $a)
    record.append(MARC::DataField.new('264', ' ', ' ', ['a', estado_pais]))

    # 9. Observações - Campo de Dados (500)
    record.append(MARC::DataField.new('500', ' ', ' ', ['a', observacoes]))

    record.to_marc
  end

end
