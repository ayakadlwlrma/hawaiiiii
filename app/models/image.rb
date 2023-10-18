class Image < ApplicationRecord
  belongs_to :aloha
  mount_uploader :image, ImageUploader
end
