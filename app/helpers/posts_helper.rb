module PostsHelper

  def article_role(post)
    case post.article_role
    when "all"
      return true
    when "friend"
      if post.user.friends.include?(current_user)
        return true
      else
        return false
      end
    when "myself"
      if post.user == current_user
        return true
      else
        return false
      end
    end
  end

end
