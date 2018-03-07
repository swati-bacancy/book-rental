json.array! @notifications do |notification| 
    json.id notification.id
    #json.recipient notification.recipient 
    json.actor notification.actor.user_name 
    json.action notification.action 
    json.notifiable notification.notifiable 
    json.url order_path(notification.notifiable.id)
end 