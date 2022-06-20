require 'net/http'
require 'uri'

b = ARGV[0]

t = Time.new(2019, 3, 29)
day = t.strftime("%d").to_i
year = t.strftime("%Y").to_s
month = t.strftime("%m").to_s

uriGet = URI.parse("http://192.168.1.35:9200/_cat/indices/*" + b + "*")
response1 = Net::HTTP.get_response(uriGet)
puts response1.body if response1.is_a?(Net::HTTPSuccess)

count = day

while count >= day - 7 do
  a = "http://192.168.1.35:9200/*" + b + "*"+ year + "." + month + "." + count.to_s + "*/_open"
  print a
  uri = URI.parse(a)
  request = Net::HTTP::Post.new(uri)
  count = count - 1


  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
end

