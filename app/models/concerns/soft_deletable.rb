# Adds soft delete functionality
# Don't forget to generate the following migration for soft deletable models:
#   rails g migration AddDeletedAtToUsers deleted_at:datetime:index
#
module SoftDeletable
  extend ActiveSupport::Concern

  included do
    define_callbacks :soft_delete, :restore
    scope :deleted, -> { where('deleted_at IS NOT ?', nil)}
    scope :not_deleted, -> { where(deleted_at: nil) }
  end

  # Marks record as deleted. But it still persists in database
  # @return [Boolean] whether record was successfully marked as deleted
  def mark_as_deleted
    unless deleted_at
      run_callbacks :soft_delete do
        self.deleted_at = Time.now
        save(validate: false)
      end
    else
      false
    end
  end

  # Marks deleted record as normal again.
  # @return [Boolean] whether record was successfully restored
  def restore
    if deleted_at
      run_callbacks :restore do
        self.deleted_at = nil
        save(validate: false)
      end
    else
      false
    end
  end

  # @return [Boolean] whether the instance is soft deleted
  def deleted?
    deleted_at.present?
  end

  module ClassMethods
    def after_soft_delete(callback)
      set_callback :soft_delete, :after, callback
    end

    def after_restore(callback)
      set_callback :restore, :after, callback
    end
  end

end