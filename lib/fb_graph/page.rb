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

    attr_accessor :name, :username, :link, :category, :founded, :is_community_page, :company_overview, :general_info, :mission, :products, :release_date, :fan_count, :location, :website, :like_count, :checkin_count, :with, :created_time

    def initialize(identifier, attributes = {})
      super
      @name     = attributes[:name]
      @username = attributes[:username]
      @link     = attributes[:link]
      @category = attributes[:category]
      if (founded = attributes[:founded])
        @founded = Date.parse(founded) rescue Date.new(founded.to_i)
      end
      @is_community_page = attributes[:is_community_page]
      @company_overview = attributes[:company_overview]
      @general_info = attributes[:general_info]
      @mission = attributes[:mission]
      if (products = attributes[:products])
        @products = products.split "\n"
      end
      if (release_date = attributes[:release_date])
        @release_date = Date.parse(release_date) rescue release_date
      end
      @fan_count = attributes[:fan_count]
      if (location = attributes[:location])
        @location = Venue.new(location)
      end
      @website = attributes[:website]
      @like_count = attributes[:likes]
      @checkin_count = attributes[:checkins]
      @with = []
      if attributes[:with]
        attributes[:with].each do |user|
          @with << User.new(user.delete(:id), user)
        end
      end
      if attributes[:created_time]
        @created_time = Time.parse(attributes[:created_time]).utc
      end
    end
  end
end