class Upload < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  has_attached_file(:file,
                    fog_directory: '2017.notmalware.ru',
                    fog_host: 'https://2017.notmalware.ru',
                    hash_secret: 'surprise',
                    hash_data: ':class/:attachment/:id/:updated_at',
                    url: 'https://2017.notmalware.ru/:hash/:filename',
                    path: ':hash/:filename',
                    use_timestamp: false)
  validates_attachment_presence :file
  do_not_validate_attachment_file_type :file
end
