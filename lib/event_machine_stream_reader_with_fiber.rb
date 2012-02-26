require 'eventmachine'
require 'em-http'
require 'fiber'

class EventMachineStreamReaderWithFiber
  def self.runner
    while (true)
      EventMachine.run do
        url = "https://stream.twitter.com/1/statuses/filter.json"
        user = 'tweetstreamer1'
        password = 'tweetstreamer'

        f = Fiber.new do |chunk|
          buffer = ""
          while (true)
            buffer << chunk
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

            chunk = Fiber.yield 0
            #
            #if (chunk.include?('"code":"FALLING_BEHIND"'))
            #  puts "GETTING TOO SLOW!!!"
            #end
          end
        end

        http = EventMachine::HttpRequest.new(url).post :head => {'Authorization' => [user, password]}, :query => {locations: '-180, -90, 180, 90'}

        http.stream { |chunk| f.resume(chunk) }

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
end