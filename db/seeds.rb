# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             employee_no: 11111,
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  employee_no = n + 1
  password = "password"
  User.create!(name:  name,
               email: email,
               employee_no: employee_no,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end