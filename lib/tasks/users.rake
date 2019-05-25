namespace :users do
  desc 'Create a set five users with fake credentials'
  task build: :environment do
    (1..5).each do |n|
      email = 'email_' + n.to_s + '@gmail.com'
      password = 'Password@123'
      user = User.new(email: email, password: password)
      user.save
    end
  end
end
