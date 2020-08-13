# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :user_id, :image, :description, :private

  index do
    selectable_column
    column :id do |post|
      post.id.truncate 15
    end
    column :user do |post|
      post.user.username
    end
    column :description do |post|
      truncate(strip_tags(markdown(post.description)), length: 60)
    end
    column :private
    column :created_at
    column :updated_at
    actions
  end

  filter :user
  filter :private
  filter :created_at
  filter :updated_at

  show do |post|
    attributes_table do
      row :id
      row :image do
        link_to 'Image', url_for(post.image), target: :blank if post.image.attached?
      end
      row 'Description' do
        markdown post.description
      end
      row :private
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :user
      f.input :image, as: :file
      f.input :description, as: :text
      f.input :private
    end

    f.actions
  end
end
