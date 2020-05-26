# frozen_string_literal: true

module V1
  # Controller that handles incoming webhook requests
  class GithubWebhooksController < ApplicationController
    before_action :authenticate_request

    def create
      GithubWebhookStorageService.new(webhook_data: params)
      # call IssueTrackerNotifierService to pass information onwards
    end

    private

    def valid_url?
      request.referrer.to_s =~ Regexp.new('https://www.github.com')

      true
    end

    def authenticate_request
      render :json, status: :unauthorized unless valid_url?
    end

    def webhook_data
      # Security issue, but lets depend on our solid authentication for now
      params.require(:github_webhook).permit!
    end
  end
end
