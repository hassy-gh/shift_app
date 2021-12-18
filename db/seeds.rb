# グループを生成する
5.times do |n|
  name = Faker::Company.name
  password = "password"
  Group.create!(name: name,
                password: password,
                password_confirmation: password)
end

# メインのサンプルユーザーを1人作成する
User.create!(name:  "山田 太郎",
             email: "example@shiftapp.com",
             employee_no: 1,
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             group_id: 1,
             join_group: true)

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
               group_id: group_id,
               join_group: true)
end

# 管理者権限を与える
groups = Group.where(id: 2..5)
groups.each do |group|
  user = group.users.first
  user.update_attribute(:admin, true)
end

# 希望シフトを生成する
users = User.all
users1 = User.where(id: 1..33)
users2 = User.where(id: 34..66)
users3 = User.where(id: 67..100)
d = Date.new(2021, 10, 2)
users.each do |user|
  user.hope_shifts.create!(start_time: "2021-10-01",
                           content: "",
                           hope_start_time: "10:00",
                           hope_end_time: "17:00")
end
30.times do |n|
  start_time = d + n
  users1.each do |user|
    user.hope_shifts.create!(start_time: start_time,
                            content: "F",
                            hope_start_time: "",
                            hope_end_time: "")
  end
  users2.each do |user|
    user.hope_shifts.create!(start_time: start_time,
                            content: "",
                            hope_start_time: "17:00",
                            hope_end_time: "22:00")
  end
  users3.each do |user|
    user.hope_shifts.create!(start_time: start_time,
                            content: "×",
                            hope_start_time: "",
                            hope_end_time: "")
  end
end
