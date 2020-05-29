# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :user_id, :description, :private

  index do
    selectable_column
    id_column
    column :user
    column :description do |post|
      post.description.truncate 60
    end
    column :private
    actions
  end

  filter :user
  filter :private

  show do |post|
    attributes_table do
      row :id
      row 'Description' do
        markdown post.description
      end
      row :private
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :description, as: :text
      f.input :private
    end

    f.actions
  end
end
