namespace :posts do
  desc 'Create a set 50 posts with fake attributes'
  task build: :environment do
    tags = %w[ember rails postgresql api grape]
    (1..50).each do |_n|
      title = Faker::Lorem.sentence
      body = Faker::Lorem.paragraph
      index = Faker::Number.between(0, 4)
      tag_list = tags[index] + ','
      index = index < 4 ? index + 1 : 0
      tag_list += tags[index]
      user_id = Faker::Number.between(1, 5)
      account_id = user_id
      post = Post.new(title: title, body: body, tag_list: tag_list, user_id: user_id, account_id: account_id)
      (1..5).each do |_m|
        answer = Faker::Lorem.paragraph
        answer_user_id = user_id < 5 ? user_id + 1 : 1
        answer_account_id = answer_user_id
        post.answers.build(body: answer, user_id: answer_user_id, account_id: answer_account_id)
      end
      post.save
    end
  end
end
