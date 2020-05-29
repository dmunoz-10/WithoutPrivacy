# frozen_string_literal: true

ActiveAdmin.register Follow do
  permit_params :followable_type, :followable_id, :follower_type, :follower_id, :blocked

  index do
    selectable_column
    id_column
    column :followable_type
    column :followable do |follow|
      User.find(follow.followable_id).username
    end
    column :follower_type
    column :follower_id do |follow|
      User.find(follow.follower_id).username
    end
    column :blocked
    actions
  end

  filter :followable_type
  filter :follower_type
  filter :followable_id
  filter :follower_id
  filter :blocked

  form do |f|
    f.inputs do
      f.input :followable_type
      f.input :followable_id
      f.input :follower_type
      f.input :follower_id
      f.input :blocked
    end

    f.actions
  end
end
