# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid records' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:external_id) }

    it { should validate_uniqueness_of(:name).scoped_to(:external_id) }
    it { should validate_uniqueness_of(:email).scoped_to(:external_id) }

    it { should have_many(:releases) }
    it { should have_many(:commits) }
  end
end
