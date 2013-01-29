module FbGraph
  module Connections
    module Permissions
      def permissions(options = {})
        remote_permissions = self.connection(:permissions, options)
        if remote_permissions.empty?
          []
        else
          remote_permissions.first.inject([]) do |arr, (key, value)|
            arr << key.to_sym if value.to_i == 1
            arr
          end
        end
      end

      def revoke!(permission = nil, options = {})
        destroy options.merge(:permission => permission, :connection => :permissions)
      end
    end
  end
end