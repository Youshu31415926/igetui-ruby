module IGeTui
  class LinkTemplate < BaseTemplate
    STRING_ATTRIBUTES = %i(title text logo logo_url url).freeze
    BOOLEAN_ATTRIBUTES = %i(is_ring is_vibrate is_clearable).freeze

    attr_accessor *STRING_ATTRIBUTES, *BOOLEAN_ATTRIBUTES

    def initialize
      super

      STRING_ATTRIBUTES.each { |attr| instance_variable_set("@#{attr}", '') }
      BOOLEAN_ATTRIBUTES.each { |attr| instance_variable_set("@#{attr}", true) }
    end

    def get_action_chain
      # set actionchain
      action_chain_1 = GtReq::ActionChain.new
      action_chain_1.actionId = 1
      action_chain_1.type = GtReq::ActionChain::Type::Goto
      action_chain_1.next = 10000

      # notification
      action_chain_2 = GtReq::ActionChain.new
      action_chain_2.actionId = 10000
      action_chain_2.type = GtReq::ActionChain::Type::Notification
      action_chain_2.title = title
      action_chain_2.text = text
      action_chain_2.logo = logo
      action_chain_2.logoURL = logo_url
      action_chain_2.ring = is_ring
      action_chain_2.clearable = is_clearable
      action_chain_2.buzz = is_vibrate
      action_chain_2.next = 10010

      # goto
      action_chain_3 = GtReq::ActionChain.new
      action_chain_3.actionId = 10010
      action_chain_3.type = GtReq::ActionChain::Type::Goto
      action_chain_3.next = 10030

      # start web
      action_chain_4 = GtReq::ActionChain.new
      action_chain_4.actionId = 10030
      action_chain_4.type = GtReq::ActionChain::Type::Startweb
      action_chain_4.url = url
      action_chain_4.next = 100

      # end
      action_chain_5 = GtReq::ActionChain.new
      action_chain_5.actionId = 100
      action_chain_5.type = GtReq::ActionChain::Type::Eoa

      [action_chain_1, action_chain_2, action_chain_3, action_chain_4, action_chain_5]
    end

    def get_push_type
      "NotifyMsg"
    end
  end
end
