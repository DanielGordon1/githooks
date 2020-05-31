# frozen_string_literal: true

module V1
  # Controller that handles incoming webhook requests
  class GithubWebhooksController < ApplicationController
    before_action :authenticate_request

    def create
      commits = storage_service.call
      IssueTrackerNotifierService.new(
        commits: commits,
        release: storage_service.handling_release?
      )
    end

    private

    def valid_url?
      request.referrer.to_s =~ Regexp.new('https://www.github.com')
    end

    def authenticate_request
      render :json, status: :unauthorized unless valid_url?
    end

    def webhook_data
      # Security issue, but lets depend on our "solid" authentication for now
      params.require(:github_webhook).permit!
    end

    def storage_service
      @storage_service ||= GithubWebhookStorageService.new(webhook_data: webhook_data.to_h)
    end
  end
end
