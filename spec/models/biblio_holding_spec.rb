require 'rails_helper'

RSpec.describe BiblioHolding, type: :model do
  context 'Validations' do
    it 'has a valid factory' do
      biblio_holding = FactoryBot.create(:biblio_holding)
      expect(biblio_holding).to be_valid
    end

    it 'is invalid when iso2709 is not present' do
      biblio_holding = FactoryBot.build(:biblio_holding, iso2709: nil)
      expect(biblio_holding).to be_invalid
    end

    it 'is invalid when iso2709 is duplicate' do
      biblio_holding = FactoryBot.create(:biblio_holding, iso2709: 'teste')
      biblio_holding_dup = FactoryBot.build(:biblio_holding, iso2709: 'teste')
      expect(biblio_holding_dup).to be_invalid
    end

    it 'is invalid when location_d is not present' do
      biblio_holding = FactoryBot.build(:biblio_holding, location_d: nil)
      expect(biblio_holding).to be_invalid
    end

    it 'is invalid when accession_number is not present' do
      biblio_holding = FactoryBot.build(:biblio_holding, accession_number: nil)
      expect(biblio_holding).to be_invalid
    end

    it 'is invalid when accession_number is duplicate' do
      biblio_holding = FactoryBot.create(:biblio_holding, accession_number: 1)
      biblio_holding_dup = FactoryBot.build(:biblio_holding, accession_number: 1)
      expect(biblio_holding_dup).to be_invalid
    end
  end

  context 'Before Save' do
    it 'set material to holdings' do
      biblio_holding = FactoryBot.create(:biblio_holding)
      expect(biblio_holding.material).to eq('holdings')
    end

    it 'set created_by to 1' do
      biblio_holding = FactoryBot.create(:biblio_holding)
      expect(biblio_holding.created_by).to eq(1)
    end

    it 'set modified_by to 1' do
      biblio_holding = FactoryBot.create(:biblio_holding)
      expect(biblio_holding.modified_by).to eq(1)
    end
  end
end
