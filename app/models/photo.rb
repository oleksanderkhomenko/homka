class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :album
  mount_uploader :image, ImageUploader
end
