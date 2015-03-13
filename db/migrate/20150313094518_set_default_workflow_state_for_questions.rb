class SetDefaultWorkflowStateForQuestions < ActiveRecord::Migration
  def up
    execute "UPDATE questions SET workflow_state = 'new'"
  end

  def down
  end
end
