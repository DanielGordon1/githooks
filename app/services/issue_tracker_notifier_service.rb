# frozen_string_literal: true

# This service will notify a the issue tracking system by means of an HTTP req
class IssueTrackerNotifierService
  def initialize(commits:)
    @commits = commits
    @url = 'https://webhook.site/0d97a487-cd54-40e1-905a-052d344eb59a'
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
