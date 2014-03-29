class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :smart_fetch

	def smart_fetch(name, options, &blk)
		in_cache = Rails.cache.fetch(name)
		return in_cache if in_cache
		val = yield
		Rails.cache.write(name, val, options)
		return val
	end
	
end
