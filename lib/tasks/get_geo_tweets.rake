require 'event_machine_jed'
require 'event_machine_stream_reader'

namespace :twitter do
  desc "get tweets"
  task(:get_tweets => :environment) do
    EventMachineJed.jed
  end

  desc "EventMachineStreamReader"
  task(:test2 => :environment) do
    EventMachineStreamReader.runner
  end

end
