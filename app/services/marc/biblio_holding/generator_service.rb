# Responsável por gerar um MARC::Record a partir de um Csv::Holding
# válido para um registro de exemplar (biblio_holding) e uma
# id de registro de bibliográfico (biblio_record)
class Marc::BiblioHolding::GeneratorService

  def initialize(csv_holding:, biblio_record:, biblio_holding:)
    @csv_holding = csv_holding
    @biblio_record = biblio_record
    @biblio_holding = biblio_holding
  end

  def call
    generate_biblio_holding_marc
  end

  private

  # def generate_biblio_holding_marc
  #   raise 'Holding inválido' unless @csv_holding.valid?

  #   record = MARC::Record.new

  #   # Campo 001: Número de controle (Número de Tombo)
  #   # ATENCAO: existe uma redundancia entre este campo MARC e o accession_number
  #   # no model. Eu suponho que é para otimizar busca
  #   record.append(MARC::ControlField.new('001', @csv_holding.nro_tombo.rjust(5, '0')))

  #   # Campo 003: Identificador do número de controle
  #   record.append(MARC::ControlField.new('003', '1'))

  #   # Campo 005: Data e hora da última transação
  #   record.append(MARC::ControlField.new('005', DateTime.now.strftime('%Y%m%d%H%M%S.%L')))

  #   # Campo 100: Autor
  #   record.append(MARC::DataField.new('100', '1', ' ', ['a', @csv_holding.autor]))

  #   # Campo 245: Título
  #   record.append(MARC::DataField.new('245', '1', '0', ['a', @csv_holding.titulo]))

  #   # Campo 260: Ano de Publicação
  #   # Ajuste os subcampos conforme necessário
  #   record.append(MARC::DataField.new('260', ' ', ' ', ['c', @csv_holding.ano]))

  #   # Campo 852: Localização da Chamada
  #   # # ATENCAO: existe uma redundancia entre este campo MARC e o location_d
  #   # no model. Eu suponho que é para otimizar busca
  #   record.append(MARC::DataField.new('852', ' ', ' ', ['a', @csv_holding.local_chamada]))

  #   record.to_marc
  # end

  def generate_biblio_holding_marc
    raise 'Holding inválido' unless @csv_holding.valid?
    raise 'Biblio Record precisa estar salvo' unless @biblio_record.persisted?
    raise 'Biblio Holding precisa estar salvo' unless @biblio_holding.persisted?

    record = MARC::Record.new

    # Campo 000: Cabeçalho do Registro
    record.append(MARC::ControlField.new('000', '00170nu a2200097un 4500'))

    # Campo 001: Número de controle (ID do registro de exemplar no banco de dados)
    record.append(MARC::ControlField.new('001', @biblio_holding.id.to_s.rjust(7, '0')))

    # Campo 004: Identificador do número de controle (ID do registro da obra no banco de dados)
    record.append(MARC::ControlField.new('004', "#{@biblio_record.id}"))

    # Campo 005: Data e hora da última transação
    record.append(MARC::ControlField.new('005', DateTime.now.strftime('%Y%m%d%H%M%S.%L')))

    # Campo 090: Código de Localização
    # Subcampo 'a' para a localização e 'e' para o exemplar
    record.append(MARC::DataField.new('090', ' ', ' ', ['a', "#{@csv_holding.local_chamada}"], ['e', 'ex.1']))

    # Campo 949: Informações Adicionais (pode ser ajustado conforme necessário)
    record.append(MARC::DataField.new('949', ' ', ' ', ['a', "#{@csv_holding.nro_tombo}"]))

    record.to_marc
  end

end
