puts 'Creating devices...'

# 適当なTodoを5つ作成
5.times do |i|
  Device.create(device_name: "device#{i + 1}", device_information: "device#{i + 1}の情報")
end

puts '...Done!'
