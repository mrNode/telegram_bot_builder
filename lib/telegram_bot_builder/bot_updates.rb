class BotUpdates
  attr_accessor :offset
  attr_accessor :limit
  attr_accessor :timeout

  def get
    method = 'getUpdates'

    params = {}

    if offset != nil
      params[:offset] = offset
    end

    if limit != nil
      params[:limit] = limit
    end

    if timeout != nil
      params[:timeout] = timeout
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
