# == Schema Information
#
# Table name: info_ways
#
#  id           :integer          not null, primary key
#  news_channel :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class InfoWay < ApplicationRecord
  has_many :guests
end