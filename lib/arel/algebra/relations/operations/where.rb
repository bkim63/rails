module Arel
  class Where < Compound
    attributes :relation, :predicates
    deriving   :==
    requires   :restricting

    def initialize(relation, *predicates)
      predicates = [yield(relation)] + predicates if block_given?
      @predicates = predicates.map { |p| p.bind(relation) }
      @relation   = relation
      @wheres = nil
    end

    def wheres
      @wheres ||= relation.wheres + predicates
    end
  end
end
