module FbGraph
  class Page < Node
    include Connections::Albums
    include Connections::Checkins
    include Connections::Events
    include Connections::Feed
    include Connections::Groups
    include Connections::Insights
    include Connections::Links
    include Connections::Notes
    include Connections::Photos
    include Connections::Picture
    include Connections::Posts
    include Connections::Statuses
    include Connections::Tagged
    include Connections::Videos
    extend Searchable

    attr_accessor :name, :username, :link, :category, :founded, :company_overview, :mission, :products, :fan_count, :location, :website, :like_count

    def initialize(identifier, attributes = {})
      super
      @name     = attributes[:name]
      @username = attributes[:username]
      @link     = attributes[:link]
      @category = attributes[:category]
      if (founded = attributes[:founded])
        @founded = Date.parse(founded) rescue Date.new(founded.to_i)
      end
      @company_overview = attributes[:company_overview]
      @mission  = attributes[:mission]
      if (products = attributes[:products])
        @products = products.split "\n"
      end
      @fan_count = attributes[:fan_count]
      if (location = attributes[:location])
        @venue = FbGraph::Venue.new(location)
      end
      @website = attributes[:website]
      @like_count = attributes[:likes]
    end
  end
end