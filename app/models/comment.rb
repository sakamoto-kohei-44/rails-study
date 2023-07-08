class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65535 }
end
