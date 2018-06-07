class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    
    # validation 검증
    # validates :content, presence: { message: "내용을 입력해주세요"}
    validates :content, presence: true
    validates :image, presence: true
    validates :user_id, presence: true
    
    belongs_to :user
    # 좋아요 기능
    has_many :likes
    # 코드 작성 시 이미 has_many 관계를 가지고 있을 수 있기 때문에
    # 별칭을 붙여주어야함
    has_many :like_users, through: :likes, source: :user
    
    # @post.toggle_like(current_user)
    def toggle_like(user)
        if self.like_users.include?(user)
            self.like_users.delete(user)             
        else
            self.like_users << user
        end
    end
end