# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubWebhookStorageService, type: :service do
  let(:service) { described_class }

  let(:push_payload) { JSON.parse(file_fixture('push.json').read) }
  let(:pull_request_payload) { JSON.parse(file_fixture('pull_request.json').read) }
  let(:release_payload) { JSON.parse(file_fixture('release.json').read) }

  describe '#call' do
    context 'with webhook data relating to a PullRequest' do
      let(:pull_service) { service.new(webhook_data: pull_request_payload) }

      it 'should select the correct handler' do
        expect(pull_service).to receive(:select_handler).and_return('pull_request')
        expect(pull_service).to receive(:handle_pull_request)
        pull_service.call
      end

      it 'should store commit objects correctly' do
        expect(Commit.count).to eq(0)
        pull_service.call
        results = Commit.where("(ticket_identifiers->'sp') IS NOT NULL")
        expect(results.count).to eq(2)
        expect(results.first).to be_an_instance_of(Commit)
      end
    end

    context 'with webhook data relating to a Push' do
      let(:push_service) { service.new(webhook_data: push_payload) }

      it 'should select the correct handler' do
        expect(push_service).to receive(:select_handler).and_return('push')
        expect(push_service).to receive(:handle_push)
        push_service.call
      end

      it 'should store commit objects correctly' do
        expect(Commit.count).to eq(0)
        push_service.call
        results = Commit.where("(ticket_identifiers->'sp') IS NOT NULL")
        expect(results.count).to eq(2)
        expect(results.first).to be_an_instance_of(Commit)
      end
    end

    context 'with webhook data relating to a Release' do
      let(:release_service) { service.new(webhook_data: release_payload) }

      it 'should select the correct handler' do
        expect(release_service).to receive(:select_handler).and_return('release')
        expect(release_service).to receive(:handle_release)
        release_service.call
      end

      it 'should store commit objects correctly' do
        expect(Commit.count).to eq(0)
        release_service.call
        results = Commit.where("
          (ticket_identifiers->'happ') IS NOT NULL OR \
          (ticket_identifiers->'cro') IS NOT NULL
        ")
        expect(results.count).to eq(2)
        expect(results.first).to be_an_instance_of(Commit)
      end

      it 'should store a release object correctly' do
        expect(Release.count).to eq(0)
        release_service.call
        results = Release.where(tag_name: '1.0.1')
        expect(results.count).to eq(1)
        expect(results.first).to be_an_instance_of(Release)
        expect(result.first.commits.count).to eq(2)
      end
    end
  end
end
