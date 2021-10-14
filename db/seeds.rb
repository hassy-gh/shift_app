# グループを生成する
5.times do |n|
  name = Faker::Company.name
  password = "password"
  Group.create!(name: name,
                password: password,
                password_confirmation: password)
end

# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             employee_no: 11111,
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             group_id: 1)

# 追加のユーザーをまとめて生成する
random = Random.new(5)
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  employee_no = n + 1
  password = "password"
  group_id = random.rand(1..5)
  User.create!(name:  name,
               email: email,
               employee_no: employee_no,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               group_id: group_id)
end

# 管理者権限を与える
groups = Group.find(2, 3, 4, 5)
groups.each do |g|
  user = g.users.first
  user.update_attribute(:admin, true)
end