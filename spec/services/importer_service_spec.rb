require 'rails_helper'

RSpec.describe ImporterService, type: :service do
  subject(:importer_service) { described_class.new }

  # Utiliza um matcher negado customizado para facilitar a leitura dos testes
  RSpec::Matchers.define_negated_matcher :not_change, :change

  describe '#call' do
    let(:csv_row_mock_1) do
      CSV::Row.new(
        [:nro_tombo, :chamada, :autor, :titulo, :local, :est_pais, :editora, :ano, :obs],
        ['123', 'AB123', 'Autor Exemplo', 'Título Exemplo', 'Cidade', 'País', 'Editora', '2020', 'Observação']
      )
    end

    let(:csv_row_mock_2) do
      CSV::Row.new(
        [:nro_tombo, :chamada, :autor, :titulo, :local, :est_pais, :editora, :ano, :obs],
        ['124', 'AB123', 'Autor Exemplo', 'Título Exemplo', 'Cidade', 'País', 'Editora', '2020', 'Observação']
      )
    end

    context 'when csv_holding is valid' do
      before do
        allow(CSV).to receive(:foreach).and_yield(csv_row_mock_1)
      end

      it 'saves all records' do
        expect { importer_service.call }.to change { BiblioRecord.count }.by(1)
          .and change { BiblioHolding.count }.by(1)
          .and change { AuthoritiesRecord.count }.by(1)
        # Verificar se o registro foi salvo no arquivo de sucesso
      end
    end

    context 'when csv_holding is not valid' do
      before do
        allow(CSV).to receive(:foreach).and_yield(csv_row_mock_1)
        allow_any_instance_of(Csv::Holding).to receive(:valid?).and_return(false)
      end

      it 'does not save any records' do
        expect { importer_service.call }.to not_change { BiblioRecord.count }
          .and not_change { BiblioHolding.count }
          .and not_change { AuthoritiesRecord.count }
        # Verificar se o registro foi salvo no arquivo de falhas
      end
    end

    context 'when processing rows with the same author but different tomb numbers' do
      before do
        allow(CSV).to receive(:foreach).and_yield(csv_row_mock_1).and_yield(csv_row_mock_2)
      end

      it 'does not create duplicate authority records for identical author' do
        expect { importer_service.call }.to change { BiblioRecord.count }.by(2)
          .and change { BiblioHolding.count }.by(2)
          .and change { AuthoritiesRecord.count }.by(1) # Should only increment once because the author is the same
        # Verificar se o registro foi salvo no arquivo de sucesso
      end
    end
  end
end
