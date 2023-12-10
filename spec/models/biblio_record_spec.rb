require 'rails_helper'

RSpec.describe BiblioRecord, type: :model do
  context 'Validations' do
    it 'has a valid factory' do
      biblio_record = FactoryBot.create(:biblio_record)
      expect(biblio_record).to be_valid
    end

    it 'is invalid when iso2709 is not present' do
      biblio_record = FactoryBot.build(:biblio_record, iso2709: nil)
      expect(biblio_record).to be_invalid
    end

    it 'is invalid when iso2709 is duplicate' do
      biblio_record = FactoryBot.create(:biblio_record, iso2709: 'teste')
      biblio_record_dup = FactoryBot.build(:biblio_record, iso2709: 'teste')
      expect(biblio_record_dup).to be_invalid
    end
  end

  context 'Before Save' do
    it 'set material to book' do
      biblio_record = FactoryBot.create(:biblio_record)
      expect(biblio_record.material).to eq('book')
    end

    it 'set created_by to 1' do
      biblio_record = FactoryBot.create(:biblio_record)
      expect(biblio_record.created_by).to eq(1)
    end

    it 'set modified_by to 1' do
      biblio_record = FactoryBot.create(:biblio_record)
      expect(biblio_record.modified_by).to eq(1)
    end
  end
end
