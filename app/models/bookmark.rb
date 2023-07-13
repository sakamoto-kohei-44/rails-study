class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates_uniqueness_of :board_id, scope: :user_id
end
