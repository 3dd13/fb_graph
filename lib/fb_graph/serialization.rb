module FbGraph
  module Serialization
    def to_hash
      raise "Define #{self.class}#to_hash!"
    end

    def to_json
      hash = self.to_hash
      hash.delete_if do |k, v|
        v.blank?
      end
      hash.to_json
    end
  end
end