module WorkflowController

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    # Defines actions for workflow events
    # see #workflow_event
    # @param events [Array<Symbol>] event names
    def workflow_events(*events)
      events.each { |event| workflow_event(event) }
    end

    # Defines action for the workflow event
    # @param events [Symbol] event name
    def workflow_event(event)
      define_method event do
        execute_workflow_event(workflow_resource, event)
      end
    end
  end

  private

    # @return [Object] resource which worflow state should be changed
    def workflow_resource
      instance_variable_get("@#{workflow_resource_class_name.underscore}")
    end

    # @return [String] name of the resource class
    def workflow_resource_class_name
      self.class.name.split('::').last.gsub('Controller', '').singularize
    end

    # Changes workflow state of the resource by sending an event to it.
    # Then redirects to the list of those resources.
    # @param resource [Object] resource which worflow state should be changed
    # @param event [Symbol] event name
    def execute_workflow_event(resource, event)
      redirect_state = resource.workflow_state
      resource.send("#{event}!")
      redirect_to url_for([:admin, resource.class, workflow_state: redirect_state]), notice: I18n.t('shared.saved')
    rescue Workflow::NoTransitionAllowed
      redirect_to url_for([:admin, resource.class, workflow_state: redirect_state]), alert: I18n.t('shared.not_saved')
    end

end
