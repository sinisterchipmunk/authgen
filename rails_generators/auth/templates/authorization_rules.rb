authorization do
  role :guest do
    has_permission_on :users, :to => [:view, :manage] do
      if_attribute :user => is { user }
    end
  end

  role :admin do
    includes :guest
  end
end

privileges do
  privilege :view do
    includes :index, :show
  end

  privilege :manage do
    includes :new, :create, :edit, :update, :destroy
  end
end
