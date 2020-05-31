# frozen_string_literal: true

class Commit < ApplicationRecord
  validates :message, :sha, :committed_at, :ticket_identifiers,
            :repository_name, presence: true
  validates :sha, uniqueness: true

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :release, optional: true

  def notification_format
    {
      query: 'state - ready for release',
      issues: unique_tickets.map { |id| { id: id } },
      comment: "See SHA #{sha}"
    }
  end

  def unique_tickets
    ticket_identifiers.map { |k, v| v.map { |n| "#{k}-#{n}" } }.flatten
  end
end
