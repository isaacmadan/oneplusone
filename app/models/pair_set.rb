class PairSet < ActiveRecord::Base

	has_many :pairs, :dependent => :destroy
	
end
