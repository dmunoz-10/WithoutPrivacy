# frozen_string_literal: true

# Message Policy
class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def destroy?
    record.user == user && record.deleted_at.nil? && Time.at(Time.now - record.created_at).utc.hour < 1
  end
end
