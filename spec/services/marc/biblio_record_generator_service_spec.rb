require 'rails_helper'

RSpec.describe Marc::BiblioRecordGeneratorService, type: :model do
  before do
    @csv_holding = FactoryBot.build(:csv_holding)
  end

  describe '#call' do
    context 'when csv_holding is valid' do
      it 'returns a MARC string' do
        service = described_class.new(csv_holding: @csv_holding)
        expect(service.call).to be_a(String)
      end
    end

    context 'when csv_holding is invalid' do
      it 'raises an error' do
        @csv_holding.nro_tombo = nil
        service = described_class.new(csv_holding: @csv_holding)
        expect { service.call }.to raise_error(RuntimeError, 'Holding inválido')
      end
    end
  end
end
