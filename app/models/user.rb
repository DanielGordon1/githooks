class User < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :external_id }
  validates :email, presence: true, uniqueness: { scope: :external_id }
  validates :external_id, presence: true, uniqueness: true
end
