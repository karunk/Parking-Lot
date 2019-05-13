module Command

  class InvalidInputError < StandardError
    
    def initialize(msg='Invalid Command. Please try again')
      super
    end

  end

end