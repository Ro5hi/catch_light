    def create_user(email)
        User.create!(email: "admin", password: "admin")
    end
  
  1...5.times do |i|
    create_user("person_#{i}@test#{i}.io")
  end