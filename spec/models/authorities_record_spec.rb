require 'rails_helper'

RSpec.describe AuthoritiesRecord, type: :model do
  context 'Validations' do
    it 'has a valid factory' do
      authorities_record = FactoryBot.create(:authorities_record)
      expect(authorities_record).to be_valid
    end

    it 'is invalid when iso2709 is not present' do
      authorities_record = FactoryBot.build(:authorities_record, iso2709: nil)
      expect(authorities_record).to be_invalid
    end

    it 'is invalid when iso2709 is duplicate' do
      authorities_record = FactoryBot.create(:authorities_record, iso2709: 'teste')
      authorities_record_dup = FactoryBot.build(:authorities_record, iso2709: 'teste')
      expect(authorities_record_dup).to be_invalid
    end
  end

  context 'Before Save' do
    it 'set created_by to 1' do
      authorities_record = FactoryBot.create(:authorities_record)
      expect(authorities_record.created_by).to eq(1)
    end

    it 'set modified_by to 1' do
      authorities_record = FactoryBot.create(:authorities_record)
      expect(authorities_record.modified_by).to eq(1)
    end
  end
end
