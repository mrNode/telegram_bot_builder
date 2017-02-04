class BotWebhook
  def setWebhook(url, certificate)
    method = 'setWebhook'

    params = {}

    if url != nil && certificate != nil
      params = {
        url: url,
        certificate: certificate
      }
    end

    uri = URI.parse(BotAPI::URLBUIDER.build(method))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    result = http.request(request)

    p result

    if result.code == '200'
      return BotAPI.parse(method, result.body)
    end
  end

  def deleteWebhook
    setWebhook(nil, nil)
  end

  def getWebhook
    method = 'getWebhookInfo'

    uri = URI.parse(BotAPI::URLBUIDER.build(method))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)

    result = http.request(request)
    p result
    if result.code == '200'
      return BotAPI.parse(method, result.body)
    end
  end
end
