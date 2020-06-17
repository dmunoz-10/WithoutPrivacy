# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagePolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new }

  permissions :create? do
  end

  permissions :destroy? do
  end
end
