# frozen_string_literal: true

RSpec.describe IssueTrackerNotifierService do
  let(:commit) { build(:commit) }
  let(:service) { described_class }
  let(:url) { 'https://webhook.site/0d97a487-cd54-40e1-905a-052d344eb59a' }

  describe '#call' do
    context 'with commits relating to a release' do
      it 'sends an HTTP req containing information about the release' do
        expect(HTTParty).to receive(:post).with(url, query: [commit.notification_format])
        service.new(commits: [commit]).call
      end
    end

    context 'with commits that do not belong to a release' do
      it 'sends an HTTP req containing information about the commit' do
        expect(HTTParty).to receive(:post).with(url, query: [commit.notification_format])
        service.new(commits: [commit]).call
      end
    end
  end
end
