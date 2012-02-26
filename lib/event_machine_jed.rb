require 'eventmachine'
require 'json'

class EventMachineJed
  def self.runner
    url = "https://stream.twitter.com/1/statuses/filter.json"
    user = 'tweetstreamer1'
    password = 'tweetstream'

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
                              screen_name: hash['user']['screen_name']
                          })
          end
        end
      end

      #on network failure, it calls this... but then the stream stops
      http.callback { |message|
        puts http.response_header.status
        puts http.response_header
        puts http.response
      }
      http.errback { |message|
        puts http.response_header.status
        puts http.response_header
        puts http.response
      }
    end
  end
end