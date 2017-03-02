module Simplepay
	class Notification
		attr_accessor :params

		def initialize(params = {})
			@params = HashWithIndifferentAccess.new(params)
		end

		def valid_signature?
			p @params[:sp_sig]
			p Simplepay::SignatureGenerator::generate_response(@params)
			@params[:sp_sig] == Simplepay::SignatureGenerator::generate_response(@params)
		end

		def success
			response = {
				sp_status: "ok",
				sp_description: "Товар передан покупалтелю",
				sp_salt: SecureRandom.urlsafe_base64
			}

			response[:sp_sig] = Simplepay::SignatureGenerator::generate_response(response)

			response
		end

		def fail
			response = {
				sp_status: "error",
				sp_description: "Ошибка платежа",
				sp_salt: SecureRandom.urlsafe_base64
			}

			response[:sp_sig] = Simplepay::SignatureGenerator::generate_response(response)

			response
		end

	end
end
