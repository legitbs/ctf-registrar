opts = (
  {
    # storage / fog / s3
    storage: :fog,
    fog_credentials: {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      scheme: 'https'
    },
    fog_directory: 'teams-2017.legitbs.net',
    fog_host: 'https://teams-2017.legitbs.net',
    fog_public: true,

    # image format
    # see http://www.imagemagick.org/script/command-line-processing.php#geometry
    styles: {
      thumb: '64x64#',
      badge: '160x120',
      medium: '256x256',
      large: '512x512'
    },

    # urls
    hash_secret: 'cats',
    hash_data: "production/:class/:attachment/:id/:style/:updated_at",
    url: 'https://teams-2017.legitbs.net/t/:hash.:extension',
    path: 't/:hash.:extension',
  })

opts.each do |k, v|
  Paperclip::Attachment.default_options[k] = v
end
