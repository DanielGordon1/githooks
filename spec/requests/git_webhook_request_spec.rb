# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GitWebhooks', type: :request do
  let(:push_payload) { file_fixture('push.json').read }
  let(:pull_request_payload) { file_fixture('pull_request.json').read }
  let(:release) { file_fixture('release.json').read }

  describe 'POST#create' do
    it 'returns http success' do
      headers = { "CONTENT-TYPE" => "application/json" }
      post '/v1/githook', params: push_payload, headers: headers

      expect(response).to have_http_status(:success)
    end
  end
end
