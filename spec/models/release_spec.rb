require 'rails_helper'

RSpec.describe Release, type: :model do
  describe 'valid records' do
    subject { create(:release) }
    it 'has a valid factory' do
      expect(build(:release)).to be_valid
    end

    it { should validate_presence_of(:tag_name) }
    it { should validate_presence_of(:released_at) }
    it { should validate_presence_of(:external_id) }

    it { should validate_uniqueness_of(:tag_name).scoped_to(:external_id) }

    it { should belong_to(:author) }
    it { should have_many(:commits) }
  end
end
