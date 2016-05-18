module Berg
  class Decorator < SimpleDelegator
    def self.decorate(object)
      if object.respond_to?(:to_a)
        object.to_a.map{ |obj| new obj }
      else
        new object
      end
    end
  end
end
