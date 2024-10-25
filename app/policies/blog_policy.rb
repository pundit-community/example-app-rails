class BlogPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    is_admin?
  end

  def edit?
    update?
  end

  def update?
    is_admin? || is_owner?
  end

  def destroy?
    update? && record.posts.count == 0
  end

  private

  def is_admin?
    user&.administrator
  end

  def is_owner?
    user&.id == record.user.id
  end
end
