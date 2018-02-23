CarrierWave.configure do |config|
  if Rails.env == 'production'
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_S3_KEY_ID'],
      aws_secret_access_key: ENV['AWS_S3_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1'
    }
    config.cache_storage = :fog
    config.fog_directory  = 's3-for-qryption/qryption'
    config.fog_public = false
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end
end
