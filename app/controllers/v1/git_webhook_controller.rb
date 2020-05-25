# frozen_string_literal: true

# Controller that handles incoming webhook requests
module V1
  class GitWebhookController < ApplicationController
    def create
      # call GitWebhookStorageService to store information.
      # call IssueTrackerNotifierService to pass information onwards
      byebug
    end
  end
end
