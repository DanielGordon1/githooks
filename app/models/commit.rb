class Commit < ApplicationRecord
  validates :message, :sha, :committed_at, :ticket_identifiers, presence: true
  validates :sha, uniqueness: true

  belongs_to :user
  belongs_to :release
end
