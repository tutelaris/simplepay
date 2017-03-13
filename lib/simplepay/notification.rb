module Simplepay
	class Notification
		attr_accessor :params

		def initialize(params = {})
			@params = HashWithIndifferentAccess.new(params)
		end

		def valid_signature?(script)
			in_sig  = @params[:sp_sig]
			out_sig = Simplepay::SignatureGenerator::generate_response(params, script)
			return in_sig == out_sig
		end

		def success
			response = {
				sp_status: "ok",
				sp_description: "Товар передан покупателю",
				sp_salt: @params[:sp_salt]
			}

			response[:sp_sig] = Simplepay::SignatureGenerator::generate_response(response)

			response.to_xml(:root => "response", :dasherize => false)
		end

		def fail
			response = {
				sp_status: "error",
				sp_description: "Ошибка платежа",
				sp_salt: @params[:sp_salt]
			}

			response[:sp_sig] = Simplepay::SignatureGenerator::generate_response(response)

			response.to_xml(:root => "response", :dasherize => false)
		end

		def reject
			response = {
				sp_status: "reject",
				sp_description: "Отказ от платежа",
				sp_salt: @params[:sp_salt]
			}

			response[:sp_sig] = Simplepay::SignatureGenerator::generate_response(response)

			response.to_xml(:root => "response", :dasherize => false)
		end

	end
end
