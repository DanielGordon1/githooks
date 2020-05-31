# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Commit, type: :model do
  let(:commit) { build(:commit, release: nil) }
  let(:required_format) do
    {
      query: 'state - ready for release',
      issues: [
        { id: 'eve-214' },
        { id: 'eve-211' },
        { id: 'sp-421' }
      ],
      comment: 'See SHA 3cb53bc31415221cfb92358dd6f7f05d6f139fec'
    }
  end

  describe 'valid records' do
    it 'has a valid factory' do
      expect(build(:release)).to be_valid
    end

    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:committed_at) }
    it { should validate_presence_of(:sha) }
    it { should validate_presence_of(:repository_name) }
    it { should validate_presence_of(:ticket_identifiers) }

    it { should belong_to(:author) }
    it { should belong_to(:release).optional }
  end

  describe '#unique_tickets' do
    it 'returns an array of strings in the correct format' do
      expect(commit.unique_tickets).to eq(%w[eve-214 eve-211 sp-421])
    end
  end

  describe '#notification_format' do
    it 'returns data about the commit in the correct format' do
      expect(commit.notification_format).to eq(required_format)
    end
  end
end
