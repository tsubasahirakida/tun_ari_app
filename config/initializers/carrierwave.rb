require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'inspigram-image-store'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/inspigram-image-store'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['aws_access_key_id'],
      aws_secret_access_key: ENV['aws_secret_access_key'],
      region: 'ap-northeast-1'
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end  
end