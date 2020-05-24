# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def follow?
    !record.blocked?(user) && !user.blocked?(record) && !user.following?(record)
  end

  def unfollow?
    !record.blocked?(user) && !user.blocked?(record) && user.following?(record)
  end

  def block?
    !user.blocked? record
  end

  def unblock?
    user.blocked? record
  end

  def followers?
    !record.blocked?(user)
  end

  def followings?
    !record.blocked?(user)
  end
end
