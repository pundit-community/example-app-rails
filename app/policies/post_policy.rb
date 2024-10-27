class PostPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user
        return scope if user.administrator?
        return scope_user_authors
      end
      scope.where publish: true
    end

    private

    def scope_user_authors
      scope.where(
        "posts.publish = true OR posts.user_id = ?",
        user.id
      )
    end
  end

  def index?
    true
  end

  def show?
    update? || record.publish
  end

  def new?
    update?
  end

  def create?
    update?
  end

  def edit?
    update?
  end

  def update?
    is_admin? || is_author?
  end

  def destroy?
    is_admin? || is_author?
  end

  private

  def is_admin?
    user&.administrator
  end

  def is_author?
    user&.id == record.user.id
  end
end
