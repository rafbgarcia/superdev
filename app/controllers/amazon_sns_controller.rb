class AmazonSnsController < ApplicationController
  skip_before_action :verify_authenticity_token # so AWS callbacks are accepted


  def bounce
    json = JSON.parse(request.raw_post)
    logger.info "bounce callback from AWS with #{json}"
    aws_needs_url_confirmed = json['SubscribeURL']

    if aws_needs_url_confirmed
      logger.info "AWS is requesting confirmation of the bounce handler URL"

      uri = URI.parse(aws_needs_url_confirmed)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.get(uri.request_uri)
    else
      logger.info "AWS has sent us the following bounce notification(s): #{json}"

      json['bounce']['bouncedRecipients'].each do |recipient|
        logger.info "AWS SES received a bounce on an email send attempt to #{recipient['emailAddress']}"
      end

      AdminMailer.notify_bounce(json).deliver_later
    end

    render nothing: true, status: 200
  end

end
