# frozen_string_literal: true

# Service that takes data from a Github webhook
# and stores updates our DB accordingly
class GithubWebhookStorageService
  def initialize(webhook_data:)
    @data = webhook_data
    @keys = @data.keys
  end

  def call
    handler = select_handler

    send("handle_#{handler}")
  end

  private

  def build_commit

  end

  def select_handler
    return 'push' unless @keys.include?('action')

    case @data['action']
    when 'released'
      'release'
    else
      'pull_request'
    end
  end

  def handle_pull_request

  end

  def handle_push

  end

  def handle_release

  end



end
