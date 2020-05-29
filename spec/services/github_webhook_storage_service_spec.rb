# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubWebhookStorageService, type: :service do
  let(:service) { described_class }
  let(:push_payload) { JSON.parse(file_fixture('push.json').read) }
  let(:pull_request_payload) { JSON.parse(file_fixture('pull_request.json').read) }
  let(:release) { JSON.parse(file_fixture('release.json').read) }

  describe '#call' do
    context 'with webhook data relating to a PullRequest' do
      it 'should store commit objects correctly' do
        instance = service.new(webhook_data: pull_request_payload)
        expect(instance).to receive(:select_handler).and_return('pull_request')
        expect(instance).to receive(:handle_pull_request)
        instance.call


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
