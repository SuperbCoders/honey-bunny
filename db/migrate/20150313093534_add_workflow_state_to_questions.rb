class AddWorkflowStateToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :workflow_state, :string
    add_index :questions, :workflow_state
  end
end
