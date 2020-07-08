# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    !record.post.user.blocked?(user)
  end

  def destroy?
    record.user == user
  end

  def like?
    !record.post.user.blocked?(user) && !record.user.blocked?(user)
  end

  def users_liked?
    record.user == user
  end
end
