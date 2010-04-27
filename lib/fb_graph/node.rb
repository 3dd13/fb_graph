module FbGraph
  class Node
    include FbGraph::Comparison

    attr_accessor :identifier, :endpoint, :token

    def initialize(identifier, options = {})
      @identifier = identifier
      @endpoint   = File.join(FbGraph::ROOT_URL, identifier)
      @token      = options[:token]
    end

    def self.fetch(identifier, options = {})
      _fetched_ = new(identifier).send(:get, options)
      new(_fetched_.delete(:id), _fetched_)
    end

    protected

    def get(options = {})
      _endpoint_ = build_endpoint(options)
      handle_response RestClient.get(_endpoint_)
    end

    private

    def build_endpoint(options = {})
      _endpoint_ = if options[:connection]
        File.join(self.endpoint, options.delete(:connection))
      else
        self.endpoint
      end
      options[:token] ||= self.token
      _options_ = options.reject do |k, v|
        v.blank?
      end
      _endpoint_ << "?#{_options_.to_query}" unless _options_.blank?
      _endpoint_
    end

    def handle_response(response)
      _response_ = JSON.parse(response.to_s).with_indifferent_access
      if _response_[:error]
        case _response_[:error][:type]
        when 'OAuthAccessTokenException'
          raise FbGraph::Unauthorized.new(_response_[:error][:message])
        when 'QueryParseException'
          raise FbGraph::NotFound.new(_response_[:error][:message])
        else
          raise FbGraph::Exception.new("#{_response_[:error][:type]} :: #{_response_[:error][:message]}")
        end
      else
        _response_
      end
    end

  end
end