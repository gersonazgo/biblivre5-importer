require 'csv'

class ImporterService
  def initialize
    @file_path = File.expand_path('../books_sample.csv', __FILE__)
    @success_file_path = File.expand_path('../success.csv', __FILE__)
    @failure_file_path = File.expand_path('../failures.csv', __FILE__)
    setup_csv_files
  end

  def call
    index = 0
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      puts "Importando registro #{index += 1}"
      csv_holding = build_csv_holding(row)
      process_csv_holding(csv_holding, row)
    end
  end

  private

  def build_csv_holding(row)
    Csv::Holding.new(
      nro_tombo: row[:nro_tombo],
      local_chamada: row[:chamada],
      autor: row[:autor],
      titulo: row[:titulo],
      local_cidade: row[:local],
      est_pais: row[:est_pais],
      editora: row[:editora],
      ano: row[:ano],
      obs: row[:obs]
    )
  end

  def process_csv_holding(csv_holding, row)
    if csv_holding.valid? && save_records_in_transaction(csv_holding)
      save_to_csv(@success_file_path, row)
    else
      save_to_csv(@failure_file_path, row)
    end
  end

  def save_records_in_transaction(csv_holding)
    ActiveRecord::Base.transaction do
      biblio_record = create_and_save_biblio_record(csv_holding)
      biblio_holding = create_and_save_biblio_holding(csv_holding, biblio_record)

      # Se alguma das gravações falhar, a transação será interrompida e false será retornado
      raise ActiveRecord::Rollback unless biblio_record.persisted? && biblio_holding.persisted?

      true
    end
  rescue ActiveRecord::Rollback
    false
  end

  def create_and_save_biblio_record(csv_holding)
    biblio_record = BiblioRecord.new
    biblio_record.iso2709 = 'temp'
    biblio_record.save!
    biblio_record.iso2709 = Marc::BiblioRecord::GeneratorService.new(csv_holding: csv_holding, biblio_record: biblio_record).call
    biblio_record.save!
    biblio_record
  end

  def create_and_save_biblio_holding(csv_holding, biblio_record)
    biblio_holding = BiblioHolding.new
    biblio_holding.biblio_record = biblio_record
    biblio_holding.location_d = 'ex. 1'
    biblio_holding.iso2709 = 'temp'
    biblio_holding.accession_number = csv_holding.nro_tombo
    biblio_holding.save!
    biblio_holding.iso2709 = Marc::BiblioHolding::GeneratorService.new(csv_holding: csv_holding, biblio_record: biblio_record, biblio_holding: biblio_holding).call
    biblio_holding.save!
    biblio_holding
  end

  def save_to_csv(file_path, row)
    CSV.open(file_path, 'a') do |csv|
      csv << row.fields
    end
  end

  def setup_csv_files
    [ @success_file_path, @failure_file_path ].each do |path|
      CSV.open(path, 'w') do |csv|
        csv << ['NRO TOMBO', 'CHAMADA', 'AUTOR', 'TITULO', 'LOCAL', 'EST/PAIS', 'EDITORA', 'ANO', 'OBS']
      end
    end
  end
end
