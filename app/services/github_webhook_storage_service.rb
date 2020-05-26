# frozen_string_literal: true

# Service that takes data from a Github webhook
# and stores updates our DB accordingly
class GithubWebhookStorageService
  def initialize(webhook_data:)
    @data = webhook_data
  end
end
