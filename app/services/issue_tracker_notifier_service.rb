# frozen_string_literal: true

# This service will notify a the issue tracking system by means of an HTTP req
class IssueTrackerNotifierService
  def initialize(commits:, release: false)
    @commits = commits
    @release = release
    @url = 'https://webhook.site/0d97a487-cd54-40e1-905a-052d344eb59a'
  end

  def call
    if @release

    else
      @commits.each { |commit| send_notification(commit.notification_format) }
    end
  end

  private

  def send_notification(body)
    HTTParty.post(@url, query: body)
  end
end
