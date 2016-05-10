module Admin
  module Persistence
    class UniquenessCheck
      attr_reader :relation, :column_name, :scope

      def initialize(relation, column_name, scope=nil)
        @relation = relation
        @column_name = column_name
        @scope = scope
      end

      def call(value)
        if scope
          relation.public_send(scope).unique?(column_name => value)
        else
          relation.unique?(column_name => value)
        end
      end
    end
  end
end
