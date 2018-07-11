module IGeTui
  class Client
    attr_accessor :client_id, :alias_name

    def initialize(client_id=nil, alias_name=nil)
      @client_id = client_id
      @alias_name = alias_name
    end
  end
end
