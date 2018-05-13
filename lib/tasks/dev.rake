namespace :dev do

  task fake_user: :environment do
    User.destroy_all

    # fake user
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "user#{i}@example.co",
        password: "user123",
        content: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
    end

    # fake post 
    User.all.each do |user|
      5.times do |i|
        role = ["all","friend","myself"]

        user.posts.create!(
          title: "user: #{user.id}, post#{i}",
          description: FFaker::Lorem::sentence(50),
          state: 'public',
          article_role: role.sample,
          views_count: rand(1..100),
          )
      end
    end

  end

  task fake_replies: :environment do
    # fake reply
    User.all.each do |user|
      5.times do |i|
        user.replies.create!(
          user: user,
          post: Post.all.sample,
          comment: FFaker::Lorem::sentence(20)
          )
      end
    end
  end

  task fake_request: :environment do

    users = User.all

    users.each do |user|
      users = users.shaffle!
      user.friend_requests.create(friend: users.pop)
    end

  end

end