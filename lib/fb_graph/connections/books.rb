module FbGraph
  module Connections
    module Books
      def books(options = {})
        books = FbGraph::Collection.new(get(options.merge(:connection => 'books')))
        books.map! do |book|
          Page.new(book.delete(:id), book.merge(
            :access_token => options[:access_token] || self.access_token
          ))
        end
      end
    end
  end
end