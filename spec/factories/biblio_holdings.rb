FactoryBot.define do
  factory :biblio_holding do
    biblio_record
    iso2709  { "teste" }
    accession_number { 1 } # tombo patrimonial
    location_d { "GH1231" } # chamada
  end
end
