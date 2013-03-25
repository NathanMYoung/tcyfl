class Playingfield < ActiveRecord::Base
  attr_accessible :city, :fieldname, :latitude, :longitude, :state, :street
end
