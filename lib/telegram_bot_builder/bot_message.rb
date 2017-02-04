class BotMessage
    attr_accessor :message_id
    attr_accessor :from # is user object
    attr_accessor :date
    attr_accessor :chat # is user object
    attr_accessor :forward_from
    attr_accessor :forward_date
    attr_accessor :reply_to_message
    attr_accessor :text
    attr_accessor :entities
    attr_accessor :audio
    attr_accessor :document
    attr_accessor :photo
    attr_accessor :sticker
    attr_accessor :video
    attr_accessor :voice
    attr_accessor :caption
    attr_accessor :contact
    attr_accessor :location
    attr_accessor :venue
    attr_accessor :new_chat_member
    attr_accessor :left_chat_member
    attr_accessor :new_chat_little
    attr_accessor :new_chat_photo
    attr_accessor :delete_chat_photo
    attr_accessor :group_chat_created
    attr_accessor :supergroup_chat_created
    attr_accessor :channel_chat_created
    attr_accessor :migrate_to_chat_id
    attr_accessor :migrate_from_chat_id
    attr_accessor :pinned_message

    # for message
    attr_accessor :text
    attr_accessor :parse_mode # :markdown, :html
    attr_accessor :disable_web_page_preview # true/false
    attr_accessor :disable_notification # true/false
    attr_accessor :reply_to_message_id # if the message is a reply, ID of the original message
    attr_accessor :reply_markup # keyboard interface for reply - :inline/:reply/:reply_hide/:force_reply

    def send
      method = 'sendMessage'
      params = {
        chat_id: chat.id,
        text: text,
      }

      if parse_mode == :markdown
        params[:parse_mode] = 'Markdown'
      elsif parse_mode == :html
        params[:parse_mode] = 'HTML'
      end

      if disable_web_page_preview != nil
        params[:disable_web_page_preview] = disable_web_page_preview
      end

      if disable_notification != nil
        params[:disable_notification] = disable_notification
      end

      if reply_markup == :inline
        params[:reply_markup] = 'InlineKeyboardMarkup'
      elsif reply_markup == :reply
        params[:reply_markup] = 'ReplyKeyboardMarkup'
      elsif reply_markup == :reply_hide
        params[:reply_markup] = 'ReplyKeyboardHide'
      elsif reply_markup == :force_reply
        params[:reply_markup] = 'ForceReply'
      end

      uri = URI.parse(BotAPI::URLBUIDER.build(method))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(params)
      result = http.request(request)

      if result.code == "200"
        return BotAPI.parse(method, result.body)
      end
    end
end
