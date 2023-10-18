class Aloha < ApplicationRecord
    mount_uploader :photo, PhotoUploader
    has_many :comments, dependent: :destroy
    has_many :images, dependent: :destroy
end
