# frozen_string_literal: true

# ChatRoom Policy
class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    current_user != record
  end
end
