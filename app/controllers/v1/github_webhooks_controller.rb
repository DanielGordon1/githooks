# frozen_string_literal: true

# Controller that handles incoming webhook requests
module V1
  class GithubWebhooksController < ApplicationController
    def create
      byebug
      # call GithubWebhookStorageService to store information.
      # call IssueTrackerNotifierService to pass information onwards
    end
  end
end
