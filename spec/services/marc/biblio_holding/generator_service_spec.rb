require 'rails_helper'

RSpec.describe Marc::BiblioHolding::GeneratorService, type: :service do
  before do
    @csv_holding = FactoryBot.build(:csv_holding)
    @biblio_record = FactoryBot.create(:biblio_record)
    @biblio_holding = FactoryBot.create(:biblio_holding)
  end

  describe '#call' do
    context 'when csv_holding is valid' do
      context 'when biblio_record is persisted' do
        context 'when biblio_holding is persisted' do
          it 'returns a MARC string' do
            service = described_class.new(csv_holding: @csv_holding, biblio_record: @biblio_record, biblio_holding: @biblio_holding)
            expect(service.call).to be_a(String)
          end
        end

        context 'when biblio_holding is not persisted' do
          it 'raises an error' do
            @biblio_holding = FactoryBot.build(:biblio_holding)
            service = described_class.new(csv_holding: @csv_holding, biblio_record: @biblio_record, biblio_holding: @biblio_holding)
            expect { service.call }.to raise_error(RuntimeError, 'Biblio Holding precisa estar salvo')
          end
        end
      end

      context 'when biblio_record is not persisted' do
        it 'raises an error' do
          @biblio_record = FactoryBot.build(:biblio_record)
          service = described_class.new(csv_holding: @csv_holding, biblio_record: @biblio_record, biblio_holding: @biblio_holding)
          expect { service.call }.to raise_error(RuntimeError, 'Biblio Record precisa estar salvo')
        end
      end
    end

    context 'when csv_holding is invalid' do
      it 'raises an error' do
        @csv_holding.nro_tombo = nil
        service = described_class.new(csv_holding: @csv_holding, biblio_record: @biblio_record, biblio_holding: @biblio_holding)
        expect { service.call }.to raise_error(RuntimeError, 'Holding inválido')
      end
    end
  end
end
