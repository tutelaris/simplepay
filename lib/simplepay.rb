require "simplepay/version"
require "simplepay/engine"
require "simplepay/signature_generator"
require "simplepay/client"
require "simplepay/configurator"
require "simplepay/payment"
require "simplepay/notification"

module Simplepay
	extend self

	def configure(&block)
		Simplepay::Client.configure(&block)
	end

	Simplepay::Configurator::ATTRIBUTES.map do |name|
	    define_method name do
	      Simplepay::Client.configuration.send(name)
	    end
	end

	def get_secret_key(is_result)
		is_result ? Simplepay.secret_key_for_result : Simplepay.secret_key
	end


	def payment_url(sp_amount, sp_description, sp_order_id)
		Simplepay::Client.get_url(sp_amount, sp_description, sp_order_id)
	end
end
