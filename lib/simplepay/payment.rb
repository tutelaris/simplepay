module Simplepay
	class Payment
		require 'rest-client'

		attr_accessor :sp_amount, :sp_description, :sp_order_id

		def self.get_url(sp_amount, sp_description, sp_order_id)
			@sp_amount 		= sp_amount
			@sp_description = sp_description
			@sp_order_id	= sp_order_id

			data = self.request_to_api
			JSON.parse(data)["sp_redirect_url"]
		end

		private 
		def self.request_to_api
			request = RestClient.post "https://api.simplepay.pro/sp/init_payment", {sp_json: self.params.to_json}, {content_type: :json, accept: :json}
			request.body
		end

		def self.params
			param = { 
				sp_amount: @sp_amount, sp_order_id: @sp_order_id, 
				sp_description: @sp_description, sp_salt: SecureRandom.urlsafe_base64, 
				sp_user_ip: '178.49.154.186'
			}

			param[:sp_payment_system] = 'TEST'  if Simplepay.development

			Simplepay::Configurator::ATTRIBUTES.map do | name |
				property = Simplepay.send(name)

				param[name] = property if name =~ /^sp_/
			end

			param[:sp_sig] = Simplepay::SignatureGenerator::generate(param)
			param
		end

	end
end
