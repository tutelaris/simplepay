module Simplepay
  class Client
    class << self
    #
    #  TODO get_url
    #  обязательных param
    #  и отсальные по желанию  -> hash
    #

      cattr_accessor :configuration

      def configure(&block)
        self.configuration = Simplepay::Configurator.new
        yield self.configuration
      end

      def get_url(sp_amount, sp_description, sp_order_id)
        Simplepay::Payment::get_url(sp_amount, sp_description, sp_order_id)
      end
    end
  end
  
end
