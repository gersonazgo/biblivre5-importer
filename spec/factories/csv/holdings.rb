# Em spec/factories/csv_holdings.rb
FactoryBot.define do
  factory :csv_holding, class: 'Csv::Holding' do
    nro_tombo { '35' }
    local_chamada { '12345' }
    autor { 'Gabriel Garcia Rodriguez' }
    titulo { 'Cem Anos de Farra' }
    local_cidade { 'Bogotá' }
    est_pais { 'Colombia' }
    editora { 'Editora XYZ' }
    ano { '1970' }
    obs { 'Edição comemorativa' }
  end
end
