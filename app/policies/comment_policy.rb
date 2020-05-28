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
end
