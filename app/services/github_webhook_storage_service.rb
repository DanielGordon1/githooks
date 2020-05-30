# frozen_string_literal: true

# Service that takes data from a Github webhook
# and stores updates our DB accordingly
class GithubWebhookStorageService
  def initialize(webhook_data:)
    @data = webhook_data
    @keys = @data.keys
    @repository_name = @data['repository']['name']
  end

  def call
    handler = select_handler

    send(:"handle_#{handler}")
  end

  def commits
    @commits ||= build_commits
  end

  private

  def build_commits
    @commit_hashes.each do |attr_hash|
      find_or_build_commit(attr_hash)
    end
  end

  def find_or_build_commit(attr_hash)
    commit = Commit.find_by(sha: attr_hash[:sha])
    return commit if commit

    sanitized_attributes = sanitize_hash(attr_hash)

    Commit.create(sanitized_attributes
          .merge(repository_name: @repository_name))
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

  def sanitize_hash(attr_hash)
    attr_hash.symbolize_keys!.then do |arg|
      arg[:author].symbolize_keys!
    end
    # find or create user relating to commit
    attr_hash[:author] = User.find_or_create_by(
      external_id: attr_hash[:author][:id],
      email: attr_hash[:author][:email],
      name: attr_hash[:author][:name]
    )
    # replace date key with committed_at
    attr_hash[:committed_at] = attr_hash.delete :date
    attr_hash[:ticket_identifiers] = build_ticket_ids(attr_hash[:message])
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
    commits
  end
end
