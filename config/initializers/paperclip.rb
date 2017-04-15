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
    fog_public: true
  })

opts.each do |k, v|
  Paperclip::Attachment.default_options[k] = v
end
