class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    
    # validation 검증
    # validates :content, presence: { message: "내용을 입력해주세요"}
    validates :content, presence: true
    validates :image, presence: true
    validates :user_id, presence: true
    
    belongs_to :user
end
