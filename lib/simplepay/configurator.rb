module Simplepay
	class Configurator 

		ATTRIBUTES = [
			:sp_outlet_id,
			:mode, :request_method, :development,
			:secret_key, :secret_key_for_result,
			:success_callback, :fail_callback, :result_callback
		]

		attr_accessor *ATTRIBUTES

		def initialize
			self.mode 					= :test
			self.request_method			= :get
			self.development 			= false
			self.sp_outlet_id 			= 1

			self.secret_key 			= "secret_key"
			self.secret_key_for_result	= "secret_key_for_result"

			self.success_callback = ->(notification) { render text: 'success' }
		    self.fail_callback    = ->(notification) { render text: 'fail' }
		    self.result_callback  = ->(notification) do
		    	render text: notification.success
		    end
		end
		
	end
  
end
