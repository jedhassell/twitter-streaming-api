require 'eventmachine'
require 'json'
require 'date'

class EventMachineStreamReader
  def self.runner
    url = "https://stream.twitter.com/1/statuses/filter.json"
    user = 'tweetstreamer1'
    password = 'tweetstreamer'

    EventMachine.run do
      http = EventMachine::HttpRequest.new(url).post :head => {'Authorization' => [user, password]}, :query => {locations: '-180, -90, 180, 90'}

      buffer = ""
      http.stream do |chunk|
        buffer += chunk
        while line = buffer.slice!(/.+\r?\n/)
          hash = JSON.parse(line)
          if (hash['coordinates'])
            Tweet.create!({
                              text: hash['text'],
                              location: [hash['coordinates']['coordinates'][0], hash['coordinates']['coordinates'][1]],
                              pic: hash['user']['profile_image_url'],
                              screen_name: hash['user']['screen_name'],
                              created_at: Time.parse(hash['created_at'])
                          })
          end
        end
      end

      #on network failure, it calls this... but then the stream stops
      http.callback {
        puts http.response_header.status
        puts http.response_header
        puts http.response
      }
      http.errback {
        puts http.response_header.status
        puts http.response_header
        puts http.response
      }
    end
  end
end