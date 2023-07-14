class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_boards, through: :bookmarks, source: :board

  def own?(object)
    id == object.user_id
  end

  def bookmark(board)
    bookmarks_boards << board
  end

  def unbookmark(board)
    bookmarks_boards.delete(board)
  end

  def bookmark?(board)
    bookmarks_boards.include?(board)
  end

  def full_name
    "#{last_name} #{first_name}"
  end
end