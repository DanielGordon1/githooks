# frozen_string_literal: true

class Release < ApplicationRecord
  validates :tag_name, :released_at, :external_id, presence: true
  validates :tag_name, uniqueness: { scope: :external_id }
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :commits
end
