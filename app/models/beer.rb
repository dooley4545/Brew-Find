class Beer < ActiveRecord::Base

  belongs_to :brewer
  belongs_to :user
end
