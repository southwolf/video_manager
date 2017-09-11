region = Rails.application.secrets.aws_region
credentials = Aws::Credentials.new(Rails.application.secrets.aws_key,
                                   Rails.application.secrets.aws_secret)

Rails.env.test? ?
    SNS_CLIENT = Aws::SNS::Client.new( stub_responses: true  ) :
    SNS_CLIENT = Aws::SNS::Client.new( region: region, credentials: credentials )