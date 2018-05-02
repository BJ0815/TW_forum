namespace :dev do

  task fake_user: :environment do
    User.destroy_all

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

  end

  task fake_request: :environment do

    user = User.first
    pending_friends = User.where.not(id: user.id)

    pending_friends.each do |friend|
      user.friend_requests.create(friend: friend)
    end

  end

end