require 'telegram_bot_builder/bot_user'
require 'telegram_bot_builder/bot_message'
require 'telegram_bot_builder/bot_updates'
require 'telegram_bot_builder/bot_update'
require 'telegram_bot_builder/bot_webhook'

class BotAPI
  def self.parse(method, result)
    data = JSON.parse(result)

    case method
    when 'getMe'
      object = BotUser.new
      object.id = data['result']['id']
      object.first_name = data['result']['first_name']
      object.username  = data['result']['username']

      return object
    when 'sendMessage'
        from            = BotUser.new
        from.id         = data['result']['from']['id']
        from.first_name = data['result']['from']['first_name']
        from.last_name  = data['result']['from']['last_name']

        chat            = BotUser.new
        chat.id         = data['result']['chat']['id']
        chat.first_name = data['result']['chat']['first_name']
        chat.last_name  = data['result']['chat']['last_name']
        chat.type       = data['result']['chat']['type']

        message = BotMessage.new
        message.message_id = data['result']['message_id']
        message.from = from
        message.chat = chat
        message.date = data['result']['date']
        message.text = data['result']['text']

        return message
    when 'getUpdates'
      result = []

      data['result'].each do |item|
        from            = BotUser.new
        from.id         = item['message']['from']['id']
        from.first_name = item['message']['from']['first_name']
        from.last_name  = item['message']['from']['last_name']

        chat            = BotUser.new
        chat.id         = item['message']['chat']['id']
        chat.first_name = item['message']['chat']['first_name']
        chat.last_name  = item['message']['chat']['last_name']
        chat.type       = item['message']['chat']['type']

        message = BotMessage.new
        message.message_id = item['message']['message_id']
        message.from = from
        message.chat = chat
        message.date = item['message']['date']
        message.text = item['message']['text']

        object = BotUpdate.new
        object.update_id = item['update_id']
        object.message = message

        result << object
      end

      return result

      when 'getWebhookInfo'
      result = {
        url: data['result']['url'],
        has_custom_certificate: data['result']['has_custom_certificate'],
        pending_update_count: data['result']['pending_update_count'],
        last_error_date: data['result']['last_error_date'],
        last_error_message: data['result']['last_error_message'],
      }

      return result
    end
  end

  class Auth
    def initialize
      #return auth
    end

    def auth
      method = 'getMe'

      uri = URI.parse(URLBUIDER.build(method))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      result = http.get(uri.request_uri)

      if result.code == "200"
        object = BotAPI.parse(method, result.body)

        return object
      end
    end
  end

  class URLBUIDER
    @@apikey

    BASEURL = 'https://api.telegram.org';

    def self.build(method)
      "#{BASEURL}/bot#{APIKEY}/#{method}"
    end

    def self.setAPIKey(apikey)
      @@apikey = apikey
    end
  end
end
