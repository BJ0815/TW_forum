module PostsHelper

  def article_role(post)
    case post.article_role
    when "all"
      true
    when "friend"
      if post.user.friends.include?(current_user) || post.user == current_user
        true
      else
        false
      end
    when "myself"
      if post.user == current_user
        true
      else
        false
      end
    end
  end

end
