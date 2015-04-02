class AddWorkflowStateToWholesalers < ActiveRecord::Migration
  def change
    add_column :wholesalers, :workflow_state, :string
  end
end
