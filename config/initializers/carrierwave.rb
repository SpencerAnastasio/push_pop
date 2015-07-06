CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJPTSKQHXEQA4XCYA',
    :aws_secret_access_key  => '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',
    :region                 => 'us-east-1',
  }
  config.fog_directory  = 'nssdemoday'                     # required
  config.fog_public     = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end
