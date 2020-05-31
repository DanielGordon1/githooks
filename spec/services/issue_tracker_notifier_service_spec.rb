# frozen_string_literal: true

RSpec.describe IssueTrackerNotifierService do

  let(:service) { described_class }
  describe '#call' do
    context 'with commits relating to a release' do
      it 'sends an HTTP req containing information about the release' do
      end
    end

    context 'with commits that do not belong to a release' do
      it 'sends an HTTP req containing information about the commit' do
        service.new(commits: [build(:commit)]).call

      end
    end
  end
end
