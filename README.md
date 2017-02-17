## 1 Install gem 

gem 'simplepay', :git => "git://github.com/SeNaP/simplepay.git"

bundle install

## 2 Create configurate file

Create simplepay.rb file in /config/initializers/

```rb
  Simplepay.configure do | config |
	config.development 				= false
	config.sp_outlet_id 			= 0000
	config.request_method			= :get
	config.secret_key 				= "token1"
	config.secret_key_for_result	= "token2"

	config.result_callback 			= ->(notification) { render json: notification.success }
	config.success_callback 		= ->(notification) { redirect_to :payments_success }
	config.fail_callback 			= ->(notification) { render text: "fail" }
end
```
