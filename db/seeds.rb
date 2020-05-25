1000.times do |index|
  Something.create(title: "Title № #{index}", created_at: Time.current - index.minutes)
end
