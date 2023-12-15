# spec/services/importer_service_spec.rb
require 'rails_helper'

RSpec.describe ImporterService, type: :service do
  subject(:importer_service) { described_class.new }

  describe '#call' do
    before do
      allow(CSV).to receive(:foreach).and_yield(csv_row_mock)
    end

    let(:csv_row_mock) do
      CSV::Row.new(
        [:nro_tombo, :chamada, :autor, :titulo, :local, :est_pais, :editora, :ano, :obs],
        ['123', 'AB123', 'Autor Exemplo', 'Título Exemplo', 'Cidade', 'País', 'Editora', '2020', 'Observação']
      )
    end

    context 'quando o csv_holding é válido e os registros são salvos com sucesso' do
      it 'salva um registro de sucesso' do
        expect { importer_service.call }.to change { BiblioRecord.count }.by(1)
          .and change { BiblioHolding.count }.by(1)
        # Verificar se o registro foi salvo no arquivo de sucesso
      end
    end

    context 'quando o csv_holding é inválido ou os registros falham ao salvar' do
      before do
        allow_any_instance_of(Csv::Holding).to receive(:valid?).and_return(false)
      end

      it 'salva um registro de falha' do
        expect { importer_service.call }.not_to change { BiblioRecord.count }
        # Verificar se o registro foi salvo no arquivo de falhas
      end
    end
  end
end
