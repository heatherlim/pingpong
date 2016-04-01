# == Schema Information
#
# Table name: tables
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Table < ActiveRecord::Base
  has_many :games
  
end
