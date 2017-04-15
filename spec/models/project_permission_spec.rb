# == Schema Information
#
# Table name: project_permissions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_project_permissions_on_project_id  (project_id)
#  index_project_permissions_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe ProjectPermission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
