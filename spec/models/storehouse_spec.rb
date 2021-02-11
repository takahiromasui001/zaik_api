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
require 'rails_helper'

RSpec.describe Storehouse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
