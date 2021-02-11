# frozen_string_literal: true

# == Schema Information
#
# Table name: storehouses
#
#  id           :bigint           not null, primary key
#  name(名前)   :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Storehouse < ApplicationRecord
  has_many :stocks
end
