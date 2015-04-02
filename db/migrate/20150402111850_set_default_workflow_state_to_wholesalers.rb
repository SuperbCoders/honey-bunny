class SetDefaultWorkflowStateToWholesalers < ActiveRecord::Migration
  def up
    execute("UPDATE wholesalers SET workflow_state='new'")
  end

  def down
  end
end
