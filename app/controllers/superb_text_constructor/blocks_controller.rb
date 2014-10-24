module SuperbTextConstructor
  class BlocksController < SuperbTextConstructor::Concerns::Controllers::BlocksController
    before_action { authorize! :manage, @parent }
  end
end
