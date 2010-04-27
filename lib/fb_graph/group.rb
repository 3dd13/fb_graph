module FbGraph
  class Group < Node
    include Connections::Feed
    include Connections::Members
    include Connections::Picture

    attr_accessor :owner, :name, :description, :link, :venue, :privacy, :updated_time

    def initialize(identifier, options = {})
      super
      if (owner = options[:owner])
        @owner = FbGraph::User.new(owner.delete(:id), owner)
      end
      @name         = options[:name]
      @description  = options[:description]
      @link         = options[:link]
      if options[:venue]
        @venue = FbGraph::Venue.new(options[:venue])
      end
      @privacy      = options[:privacy]
      @updated_time = options[:updated_time]
    end
  end
end