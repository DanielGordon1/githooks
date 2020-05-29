# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GitWebhooks', type: :request do
  let(:push_payload) { file_fixture('push.json').read }
  let(:pull_request_payload) { file_fixture('pull_request.json').read }
  let(:release) { file_fixture('release.json').read }
  let(:service) do
    service = double('GithubWebhookStorageService')
    expect(service).to receive(:call)
    service
  end

  describe 'POST#create' do
    it 'returns http success' do
      expect(GithubWebhookStorageService).to receive(:new).and_return(service)

      headers = { 'CONTENT-TYPE' => 'application/json', 'HTTP_REFERER' => 'https://www.github.com' }
      post '/v1/github', params: push_payload, headers: headers

      expect(response).to have_http_status(:success)
    end
  end
end
