# Responsável por gerar um MARC::Record a partir de um Csv::Holding
# válido para um registro de bibliográfico (biblio_record)
class Marc::BiblioRecordGeneratorService

  def initialize(csv_holding:)
    @csv_holding = csv_holding
  end

  def call
    generate_biblio_record_marc
  end

  private

  def generate_biblio_record_marc
    raise 'Holding inválido' unless @csv_holding.valid?

    record = MARC::Record.new

    # 2. Chamada/Localização - Campo de Controle (001)
    record.append(MARC::ControlField.new('001', @csv_holding.local_chamada))

    # 3. Autor - Campo de Dados (100)
    record.append(MARC::DataField.new('100', '1', ' ', ['a', @csv_holding.autor]))

    # 4. Título - Campo de Dados (245)
    record.append(MARC::DataField.new('245', '1', '0', ['a', @csv_holding.titulo]))

    # 5. Local (Cidade) - Subcampo do Campo de Dados (260 $a)
    # 7. Editora - Subcampo do Campo de Dados (260 $b)
    # 8. Ano - Subcampo do Campo de Dados (260 $c)
    record.append(MARC::DataField.new('260', ' ', ' ', ['a', @csv_holding.local_cidade], ['b', @csv_holding.editora], ['c', @csv_holding.ano]))

    # 6. Estado/País - Campo de Dados (264 $a)
    record.append(MARC::DataField.new('264', ' ', ' ', ['a', @csv_holding.est_pais]))

    # 9. Observações - Campo de Dados (500)
    record.append(MARC::DataField.new('500', ' ', ' ', ['a', @csv_holding.obs]))

    record.to_marc
  end
end
