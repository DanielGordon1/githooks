class Release < ApplicationRecord
  validates :tag_name, :released_at, :external_id, presence: true
  validates :tag_name, uniqueness: { scope: :external_id }
  belongs_to :user
end
