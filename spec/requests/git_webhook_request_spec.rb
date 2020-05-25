# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GitWebhooks', type: :request do
  describe 'POST#create' do
    it 'returns http success' do
      post '/githook'

      expect(response).to have_http_status(:success)
    end
  end
end
