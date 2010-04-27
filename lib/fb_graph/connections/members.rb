module FbGraph
  module Connections
    module Members
      def members(options = {})
        members = FbGraph::Collection.new(get(options.merge(:connection => 'members')))
        member.map! do |member|
          if member[:category]
            Page.new(member.delete(:id), member)
          else
            User.new(member.delete(:id), member)
          end
        end
      end
    end
  end
end