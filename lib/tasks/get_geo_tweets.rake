require 'event_machine_stream_reader_with_fiber'
require 'event_machine_stream_reader'

namespace :twitter do

  desc "get tweets using fiber"
  task(:get_tweets_with_fiber => :environment) do
    EventMachineStreamReaderWithFiber.runner
  end

  desc "get tweets"
  task(:get_tweets => :environment) do
    EventMachineStreamReader.runner
  end

end
