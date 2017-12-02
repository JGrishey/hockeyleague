json.array! @messages do |message|
    json.id message.id
    json.body message.body
    json.author User.find(message.user_id).user_name
    json.time time_ago_in_words(message.created_at)
end