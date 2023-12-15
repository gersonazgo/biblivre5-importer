
# Responsável por gerar um MARC::Record a partir de um Csv::Holding
# válido para um registro de autor (authorities_record)
class Marc::AuthoritiesRecord::GeneratorService
  # Inicializa o serviço com o nome do autor e o número de controle
  def initialize(csv_holding:, authorities_record:)
    @csv_holding = csv_holding
    @authorities_record = authorities_record
  end

  # Método público para gerar o registro MARC
  def call
    generate_authorities_record_marc
  end

  private

  def generate_authorities_record_marc
    raise 'Holding inválido' unless @csv_holding.valid?
    raise 'Authority Record precisa estar salvo' unless @authorities_record.persisted?

    # Cria um novo registro MARC em branco
    record = MARC::Record.new

    # Campo 001 - Número de controle da autoridade
    # Este número é geralmente um identificador único para o registro no sistema
    record.append(MARC::ControlField.new('001', @authorities_record.id.to_s.rjust(7, '0')))

    # Campo 005 - Data e hora da última transação
    # Formato AAAAMMDDHHMMSS.0, onde 0 representa os décimos de segundo
    record.append(MARC::ControlField.new('005', Time.now.strftime('%Y%m%d%H%M%S.%L')))

    # Campo 008 - Elementos de dados de comprimento fixo
    # Contém 40 caracteres com informações codificadas, como data de entrada,
    # idioma e país do registro, e outros elementos específicos de registros de autoridade
    record.append(MARC::ControlField.new('008', '231106n|||| a||||b|||||||c|por|d'))

    # Campo 100 - Cabeçalho de Nome Pessoal
    # O subcampo 'a' contém o nome do autor
    # Indicadores podem ser ajustados conforme a necessidade e as regras de catalogação
    record.append(MARC::DataField.new('100', '1', ' ', ['a', @csv_holding.autor]))

    # Atualização do líder após conhecer o comprimento do registro
    # O 'leader' é ajustado com o tamanho correto do registro e outras informações técnicas
    update_leader(record)

    # Retorna a representação em formato MARC do registro
    record.to_marc
  end

  # Atualiza o líder com informações sobre o registro
  def update_leader(record)
    # O líder tem 24 caracteres que fornecem informações sobre o registro
    record_length = record.to_marc.length.to_s.rjust(5, '0')
    record.leader[0..4] = record_length # Define o comprimento do registro
    record.leader[6] = 'z'              # Tipo de registro (neste caso, autoridade)
    record.leader[9] = 'a'              # Tipo de controle (a: arquivístico)
    record.leader[10] = '2'             # Contagem de indicadores (2 é típico para autoridade)
    record.leader[11] = '2'             # Contagem de códigos de subcampo (2 é comum)
    record.leader[17] = ' '             # Byte 17 do líder é reservado e normalmente contém um espaço em branco
    record.leader[18] = 'a'             # Convenção de entrada (a: ISBD)
  end
end
