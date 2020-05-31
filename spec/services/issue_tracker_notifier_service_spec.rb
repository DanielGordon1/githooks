# frozen_string_literal: true

RSpec.describe IssueTrackerNotifierService do
  desribe '#call' do
    context 'with commits relating to a release' do
      it 'sends an HTTP req containing information about the release' do
      end
    end

    context 'with commits that do not belong to a release' do
      it 'sends an HTTP req containing information about the commit' do
      end
    end
  end
end
