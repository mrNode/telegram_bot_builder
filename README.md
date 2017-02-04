Telegram Bot Builder
===================

Updates
-------------
```
updates = BotUpdates.new
updates.offset = ...
updates.limit  = ...

updateList = updates.get
```

Update
----------------
update_id
message
date
text

Send message
--------------------
```
message = Message.new
message.text = 'Hello World!'

update = ...
update.message.from.sendMessage(message)
```
