# Responsável por gerar um MARC::Record a partir de um Csv::Holding
# válido para um registro de bibliográfico (biblio_record)
class Marc::BiblioRecord::GeneratorService

  def initialize(csv_holding:, biblio_record:)
    @csv_holding = csv_holding
    @biblio_record = biblio_record
  end

  def call
    generate_biblio_record_marc
  end

  private

  def generate_biblio_record_marc
    raise 'Holding inválido' unless @csv_holding.valid?
    raise 'Biblio Record precisa estar salvo' unless @biblio_record.persisted?

    record = MARC::Record.new

    # Supondo que @biblio_record possui um campo de ID único que possa ser usado aqui
    # Ajustar este campo conforme necessário
    record_id = @biblio_record.id || '0000000'
    record.append(MARC::ControlField.new('001', record_id.to_s.rjust(7, '0')))

    record.append(MARC::ControlField.new('005', Time.now.strftime('%Y%m%d%H%M%S.%L')))

    # Supondo que todos os registros são do tipo 'cam' para o campo '008'
    # Isso pode precisar de ajuste conforme o tipo de material
    record.append(MARC::ControlField.new('008', '231106s|||| bl|||||||||||||||||por|u'))

    # Campo 090: Código de Localização
    record.append(MARC::DataField.new('090', ' ', ' ', ['a', @csv_holding.local_chamada]))

    # Campo 100: Autor Principal
    record.append(MARC::DataField.new('100', '1', ' ', ['a', @csv_holding.autor]))

    # Campo 245: Título
    record.append(MARC::DataField.new('245', '1', '0', ['a', @csv_holding.titulo]))

    # Campo 260: Ano de Publicação, Cidade e Editora
    record.append(MARC::DataField.new('260', ' ', ' ', ['a', @csv_holding.local_cidade], ['b', @csv_holding.editora], ['c', @csv_holding.ano]))

    # Campo 500: Notas Gerais (Observações)
    record.append(MARC::DataField.new('500', ' ', ' ', ['a', @csv_holding.obs]))

    temp_leader = ' ' * 24
    record.leader = temp_leader
    record_length = record.to_marc.length.to_s.rjust(5, '0')
    material_code = 'cam'
    record.leader = "#{record_length}#{material_code} a2200109 a 4500"

    record.to_marc
  end

end
