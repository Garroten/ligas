class Tournament < ActiveRecord::Base
  belongs_to :user
  belongs_to :sport
  has_many   :candidates
  
  attr_accessor :candidatos
  attr_reader :candidatos
end
