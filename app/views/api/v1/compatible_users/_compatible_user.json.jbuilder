json.id              compatible_user.id
json.name            compatible_user.name
json.image           compatible_user.image
json.room_id         current_user.conversation_with(compatible_user).id
json.unread_messages current_user.unread_messages_with(compatible_user)
