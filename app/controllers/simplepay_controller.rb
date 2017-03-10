class SimplepayController < ApplicationController

	skip_before_action :verify_authenticity_token
	before_action :create_notification

	def result
		if @notification.valid_signature?('result')
			instance_exec @notification, &Simplepay.result_callback
		else
			instance_exec @notification, &Simplepay.fail_callback
		end

	end

	def success
		if @notification.valid_signature?('success')
			instance_exec @notification, &Simplepay.success_callback
		else
			instance_exec @notification, &Simplepay.fail_callback
		end
	end


	def fail
		instance_exec @notification, &Simplepay.fail_callback
	end


	private


	def create_notification
		#if request.get?
		#  @notification = Simplepay::Notification.new request.query_parameters
		#elsif request.post?
		#  @notification = Simplepay::Notification.new request.request_parameters
		#end
		unless request.request_parameters.blank?
			paramters = request.request_parameters
		else
			paramters = request.query_parameters
		end

		@notification = Simplepay::Notification.new(paramters)
	end

end
