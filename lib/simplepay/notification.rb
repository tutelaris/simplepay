module Simplepay
	class Notification
		attr_accessor :params

		def initialize(params = {})
			@params = HashWithIndifferentAccess.new(params)
		end

		def valid_signature?(script)
			p @params[:sp_sig]
			p Simplepay::SignatureGenerator::generate_response(@params, script)
			@params[:sp_sig] == Simplepay::SignatureGenerator::generate_response(@params, script)
		end

		def success
			response = {
				sp_status: "ok",
				sp_description: "Товар передан покупателю",
				sp_salt: SecureRandom.urlsafe_base64
			}

			response[:sp_sig] = Simplepay::SignatureGenerator::generate_response(response)

			response.to_xml(:root => "response", :dasherize => false)
		end

		def fail
			response = {
				sp_status: "error",
				sp_description: "Ошибка платежа",
				sp_salt: SecureRandom.urlsafe_base64
			}

			response[:sp_sig] = Simplepay::SignatureGenerator::generate_response(response)

			response.to_xml(:root => "response", :dasherize => false)
		end

		def reject
			response = {
				sp_status: "reject",
				sp_description: "Отказ от платежа",
				sp_salt: SecureRandom.urlsafe_base64
			}

			response[:sp_sig] = Simplepay::SignatureGenerator::generate_response(response)

			response.to_xml(:root => "response", :dasherize => false)
		end

	end
end
