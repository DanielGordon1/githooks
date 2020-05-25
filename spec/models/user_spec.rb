# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid records' do
    it 'had a valid factory' do
      expect(build(:user)).to be_valid
    end
  end
end
