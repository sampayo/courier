class Historico < ActiveRecord::Base
	      validates :tipo	 , :presence => true
	      belongs_to :ordens
	      belongs_to :direccions
end
