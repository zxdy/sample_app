namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # make_users
    # make_microposts
    # make_relationships
    make_jobs
  end

  def make_users
    User.create!(name: "Example User",
                 email: "test@test.com",
                 password: "123456",
                 password_confirmation: "123456",
                 admin: true)
    10.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
  def make_microposts
    users = User.all
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
  def make_relationships
    users = User.all
    user  = users.first
    followed_users = users[2..50]
    followers      = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
  end

  def make_jobs
    50.times do
      log_date=Time.now
      pool_name="tsj1"
      server_list="aosdjcapow.com"
      fail_time=Time.now
      Jobs.create!(logdate: log_date,
                   poolname: pool_name,
                   serverlist:server_list,
                   failtime:fail_time)
    end
  end
end