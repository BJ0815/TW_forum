module PostsHelper

  def create_user_list
    user1 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user1')
    user2 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user2')
    user3 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user3')
    user4 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user4')
    user5 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user5')
    user6 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user6')
    user7 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user7')
    user8 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user8')
    user9 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user9')
    user10 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user10')
    user11 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user11')
    user12 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user12')
    user13 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user13')
    user14 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user14')
    user15 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user15')
  end

  def create_posts_list
    User.first.posts.create(
      [{ title: 'first post', description: 'first post', state: 'public', article_role: 'all',created_at: 5.days.ago },
      { title: 'second post', description: 'first post', state: 'public', article_role: 'all', created_at: 4.days.ago },
      { title: 'third post', description: 'first post', state: 'public', article_role: 'all', created_at: 3.days.ago },
      { title: 'forth post', description: 'first post', state: 'public', article_role: 'all', created_at: 2.days.ago },
      { title: 'fifth post', description: 'first post', state: 'public', article_role: 'all', created_at: 1.days.ago }]
      )
  end

end