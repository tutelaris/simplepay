module Simplepay
  class SignatureGenerator < ::Rails::Engine
    class << self
      attr_accessor :params
      
      def generate(params)
        @params = params
        action = params["action"]
        delete_rails_params
        action = 
          if params_for_result?
            params.delete("sp_sig") 
            params["action"]
          else
            "init_payment"
          end
        sorted_params_values = params.sort.to_h.values
        sorted_params_values.unshift(action)
        sorted_params_values.push(secret_key)
        md5(sorted_params_values.join(";"))
      end

      private

      def delete_rails_params
        params.delete("action")
        params.delete("controller")
      end

      def secret_key
        Simplepay.get_secret_key(params_for_result?)
      end

      def params_for_result?
        params["sp_result"].to_i == 1
      end


      def md5(data)
        Digest::MD5.hexdigest(data)
      end
    end
  end
end