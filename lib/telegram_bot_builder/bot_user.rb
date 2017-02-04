class BotUser
  attr_accessor :id
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :username
  attr_accessor :type

  def sendMessage(message)
    message.chat = self

    message.send
  end
end
