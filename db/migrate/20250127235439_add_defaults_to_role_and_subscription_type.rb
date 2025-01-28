class AddDefaultsToRoleAndSubscriptionType < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :role, 0
    change_column_default :users, :subscription_type, 0
  end
end
