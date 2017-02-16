Rails.application.routes.draw do
  scope :simplepay do
    %w(result success fail).map do |route|
      match route,
            controller: :simplepay,
            action: route,
            via: Simplepay.request_method
    end
  end
end