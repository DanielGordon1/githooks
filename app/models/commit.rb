# frozen_string_literal: true

# Definition of the Commit model
class Commit < ApplicationRecord
  enum status: %w[unreleased released]
  validates :message, :sha, :committed_at, :ticket_identifiers,
            :repository_name, presence: true
  validates :sha, uniqueness: true

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :release, optional: true

  before_save :update_released_status, if: :will_save_change_to_release_id?

  def notification_format
    {
      query: "state - #{released? ? 'released' : 'ready for release'}",
      issues: unique_tickets.map { |id| { id: id } },
      comment: "See SHA #{sha}"
    }
  end

  def unique_tickets
    ticket_identifiers.map { |k, v| v.map { |n| "#{k}-#{n}" } }.flatten
  end

  private

  def update_released_status
    self.status = release.nil? ? 'unreleased' : 'released'
  end
end
