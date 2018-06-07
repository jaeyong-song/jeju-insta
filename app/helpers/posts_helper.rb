module PostsHelper
    def like_button post, user
        link_to "#{post.like_users.include?(user) ? '좋아요 취소' : '좋아요'}", like_post_path, method: :post
    end
end
