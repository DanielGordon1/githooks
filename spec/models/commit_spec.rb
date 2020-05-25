require 'rails_helper'

RSpec.describe Commit, type: :model do
  describe 'valid records' do
    it 'has a valid factory' do
      expect(build(:release)).to be_valid
    end

    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:committed_at) }
    it { should validate_presence_of(:sha) }

    it { should belong_to(:user) }
    it { should belong_to(:release) }
  end
end
