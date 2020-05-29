# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubWebhookStorageService do
  let(:push_payload) { file_fixture('push.json').read }
  let(:pull_request_payload) { file_fixture('pull_request.json').read }
  let(:release) { file_fixture('release.json').read }

  describe '#call' do
    context 'with webhook data relating to a PullRequest' do
      it 'should store commit objects correctly' do

      end
    end

    context 'with webhook data relating to a Push' do
      it 'should store commit objects correctly' do

      end
    end

    context 'with webhook data relating to a Release' do
      it 'should store commit objects correctly' do

      end
    end
  end
end
