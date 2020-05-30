# frozen_string_literal: true

# Service that takes data from a Github webhook
# and stores updates our DB accordingly
class GithubWebhookStorageService
  def initialize(webhook_data:)
    @data = webhook_data
    @keys = @data.keys
    @repository_name = @data['repository']['name']
    @release = false
  end

  def call
    handler = select_handler

    send(:"handle_#{handler}")
  end

  def commits
    @commits ||= build_commits
  end

  def handling_release?
    @release
  end

  private

  def build_commits
    @commit_hashes.each do |attr_hash|
      find_or_build_commit(attr_hash)
    end
  end

  def build_ticket_ids(string)
    constructor = Hash.new { |h, k| h[k] = [] }
    string.match(/#\w{1,4}-\d{1,4}/)
          .to_a
          .each_with_object(constructor) do |ticket, acc|
      ticket.gsub('#', '')
            .split('-')
            .then { |result| acc[result[0]] << result[1] }
    end
  end

  def find_or_build_commit(attr_hash)
    commit = Commit.find_by(sha: attr_hash[:sha])
    return commit if commit

    sanitized_attributes = sanitize_attributes(attr_hash)

    Commit.create(sanitized_attributes
          .merge(repository_name: @repository_name))
  end

  def find_or_build_user(author_hash)
    User.find_or_create_by(
      external_id: author_hash[:id],
      email: author_hash[:email],
      name: author_hash[:name]
    )
  end

  def find_or_build_release
    Release.find_or_create_by(
      external_id: @data['release']['id'],
      tag_name: @data['release']['tag_name'],
      released_at: @data['released_at'],
      author: find_or_build_user(@data['release']['author'])
    )
  end

  def sanitize_attributes(attr_hash)
    attr_hash.deep_symbolize_keys!

    attr_hash[:author] = find_or_build_user(attr_hash[:author])
    attr_hash[:committed_at] = attr_hash.delete :date
    attr_hash[:ticket_identifiers] = build_ticket_ids(attr_hash[:message])
    attr_hash[:release] = find_or_build_release if @release

    attr_hash
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
    @commit_hashes = @data['pull_request']['commits']
    commits
  end

  def handle_push
    @commit_hashes = @data['commits']
    commits
  end

  def handle_release
    @commit_hashes = @data['release']['commits']
    @release = true
    commits
  end
end
