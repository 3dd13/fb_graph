module FbGraph
  class Page < Node
    include Connections::Feed
    include Connections::Picture
    include Connections::Tagged
    include Connections::Links
    include Connections::Photos
    include Connections::Groups
    include Connections::Albums
    include Connections::Statuses
    include Connections::Videos
    include Connections::Notes
    include Connections::Posts
    include Connections::Members
    include Connections::Events
    extend Searchable

    attr_accessor :name, :link, :category, :founded, :company_overview, :mission, :products, :fan_count

    def initialize(identifier, attributes = {})
      super
      @name     = attributes[:name]
      @link     = attributes[:link]
      @category = attributes[:category]
      @founded  = attributes[:founded]
      @company_overview = attributes[:company_overview]
      @mission  = attributes[:mission]
      if (products = attributes[:products])
        @products = products.split "\n"
      end
      @fan_count = attributes[:fan_count]
    end
  end
end