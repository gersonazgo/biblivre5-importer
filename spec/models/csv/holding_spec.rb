require 'rails_helper'

RSpec.describe Csv::Holding, type: :model do
  context 'Validations' do
    it 'has a valid factory' do
      csv_holding = FactoryBot.build(:csv_holding)
      expect(csv_holding).to be_valid
    end

    it 'is invalid without nro_tombo' do
      csv_holding = FactoryBot.build(:csv_holding, nro_tombo: nil)
      expect(csv_holding).to be_invalid
    end

    it 'is invalid without local_chamada' do
      csv_holding = FactoryBot.build(:csv_holding, local_chamada: nil)
      expect(csv_holding).to be_invalid
    end

    it 'is invalid without autor' do
      csv_holding = FactoryBot.build(:csv_holding, autor: nil)
      expect(csv_holding).to be_invalid
    end

    it 'is invalid without titulo' do
      csv_holding = FactoryBot.build(:csv_holding, titulo: nil)
      expect(csv_holding).to be_invalid
    end
  end
end
