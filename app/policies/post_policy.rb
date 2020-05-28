# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    (!record.private? && !record.user.blocked?(user)) || record.user == user
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def like?
    (!record.private? && !record.user.blocked?(user)) || record.user == user
  end

  def users_liked?
    return true if !user && !record.private?

    (!record.private? && !record.user.blocked?(user)) || record.user == user
  end
end
