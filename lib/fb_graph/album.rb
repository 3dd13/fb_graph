module FbGraph
  # == Album object
  #
  # === Attributes
  #
  # +from+::         FbGraph::User or FbGraph::Page
  # +name+::         String
  # +description+::  String
  # +location+::     String <em>ex.) "NYC"</em>
  # +link+::         String
  # +privacy+::      String <em>ex.) "everyone"</em>
  # +count+::        Integer
  # +created_time+:: Time (UTC)
  # +updated_time+:: Time (UTC)
  #
  # === Connections
  #
  # +photos+::   Array of FbGraph::Photo
  # +comments+:: Array of FbGraph::Comment
  # +likes+::    Array of FbGraph::Page
  #
  # === Notes
  #
  # ==== Attribute +from+
  #
  # Both facebook user and page can have albums, so +from+ can be either FbGraph::User or FbGraph::Page.
  # * When you called +ablums+ connection of FbGraph::User, all +from+ should be FbGraph::User.
  # * When you called +ablums+ connection of FbGraph::Page, all +from+ should be FbGraph::Page.
  # * When you fetched an album by objedt id, +from+ can be either FbGraph::User or FbGraph::Page.
  #
  # ==== Cached Comments
  #
  # When album object fetched, several comments are included in the response.
  # So first time you called +album.comments+, those cached comments will be returned.
  # If you put any option parameter like +album.comments(:access_token => ACCESS_TOKEN)+,
  # fb_graph ignores those cached comments and fetch comments via Graph API.
  #
  # <em>If cached "album.comments" are blank, probably the album has no comments yet.</em>
  class Album < Node
    include Connections::Photos
    include Connections::Comments
    include Connections::Likes

    attr_accessor :from, :name, :description, :location, :link, :privacy, :count, :created_time, :updated_time

    def initialize(identifier, attributes = {})
      super
      if (from = attributes[:from])
        @from = if from[:category]
          FbGraph::Page.new(from.delete(:id), from)
        else
          FbGraph::User.new(from.delete(:id), from)
        end
      end
      @name = attributes[:name]
      # NOTE:
      # for some reason, facebook uses different parameter names.
      # "description" in GET & "message" in POST
      # TODO:
      # check whether this issue is solved or not
      @description = attributes[:description] || attributes[:message]
      @location    = attributes[:location]
      @link        = attributes[:link]
      @privacy     = attributes[:privacy]
      @count       = attributes[:count]
      if attributes[:created_time]
        @created_time = Time.parse(attributes[:created_time]).utc
      end
      if attributes[:updated_time]
        @updated_time = Time.parse(attributes[:updated_time]).utc
      end

      # cached connection
      @_comments_ = FbGraph::Collection.new(attributes[:comments])
    end
  end
end