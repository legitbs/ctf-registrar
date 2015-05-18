list = %w{b059 b058 b057 b056 b055 b054 b053 b052 b051 b050 b048 a047 a046 b045 a044 a041 a040 a039 a038 a037}

list.each do |e|
  url = `heroku pg:backups public-url #{e} -a ctf-registrar-2015-prod`
  `curl -o tmp/#{e}.pgdump "#{url}"`
end
