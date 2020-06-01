# frozen_string_literal: true

# This service will notify a the issue tracking system by means of an HTTP req
class IssueTrackerNotifierService
  def initialize(commits:)
    @commits = commits
    @url = ENV['WEBHOOK_URL']
  end

  def call
    @commits.map(&:notification_format)
            .then { |body| send_notification(body) }
  end

  private

  def send_notification(body)
    HTTParty.post(@url, query: body)
  end
end
