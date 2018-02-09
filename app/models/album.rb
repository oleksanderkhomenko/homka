class Album < ApplicationRecord
  enum private: { public_album: 0, private_album: 1 }
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :name, presence: true
  validates :private, presence: true
end
