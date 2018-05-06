FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "user123"}
  end

  factory :category do
    sequence(:name) { |n| "category#{n}" }
  end

  factory :post do
    sequence(:title) { |n| "post#{n}" }
    description { FFaker::Lorem.paragraph }
    state { "public" }
    article_role { "all" }
    user
  end

  factory :reply do
    comment { FFaker::Lorem.sentence }
    user
    post
  end

  factory :friend_request do
    user
    friend
  end

end