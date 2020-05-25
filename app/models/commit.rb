class Commit < ApplicationRecord
  belongs_to :user
  belongs_to :release
  belongs_to :user
end
