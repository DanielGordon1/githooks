# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GitWebhooks', type: :request do
  describe 'post /create' do
    it 'returns http success' do
      get '/git_webhook/create'
      expect(response).to have_http_status(:success)
    end
  end
end
