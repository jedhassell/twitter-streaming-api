class Tweet
  include Mongoid::Document
  include Mongoid::Spacial::Document

  field :location, type: Array, spacial: true

  #store_in :tweets, capped: true, size: 1000000000, max: 100000
  store_in :tweets, capped: true, size: 10000000, max: 1000
  spacial_index :location

end
