CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_S3_KEY_ID'],
    aws_secret_access_key: ENV['AWS_S3_SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1',
    host: 's3.example.com', ,
    endpoint: 'https://s3.example.com:8080'
  }
  config.cache_storage = :fog
  config.fog_directory  = 'qryption'
  config.fog_public = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
