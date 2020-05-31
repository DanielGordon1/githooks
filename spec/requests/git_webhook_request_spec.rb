# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GithubWebhooks', type: :request do
  let(:push_payload) { file_fixture('push.json').read }
  let(:storage_service) do
    service = double('GithubWebhookStorageService')
    expect(service).to receive(:call)
    expect(service).to receive(:handling_release?)
    service
  end

  let(:notification_service) do
    service = double('IssueTrackerNotifierService')
    expect(service).to receive(:call)
    service
  end

  describe 'POST#create' do
    context 'with correct referrer' do
      it 'returns http success' do
        expect(GithubWebhookStorageService).to receive(:new).and_return(storage_service)
        expect(IssueTrackerNotifierService).to receive(:new).and_return(notification_service)

        headers = { 'CONTENT-TYPE' => 'application/json', 'HTTP_REFERER' => 'https://www.github.com' }
        post '/v1/github', params: push_payload, headers: headers

        expect(response).to have_http_status(:success)
      end
    end

    context 'with incorrect referrer' do
      it 'returns http unauthorized' do
        headers = { 'CONTENT-TYPE' => 'application/json', 'HTTP_REFERER' => 'https://www.some_other_hub.com' }
        post '/v1/github', params: push_payload, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
