# frozen_string_literal: true

ActiveAdmin.register Comment, as: 'PostComment' do
  permit_params :post_id, :user_id, :text

  index do
    selectable_column
    column :id do |comment|
      comment.id.truncate 11
    end
    column :user
    column :post do |comment|
      comment.post.id.truncate 11
    end
    column :text do |comment|
      comment.text.truncate 60
    end
    actions
  end

  filter :user
  filter :post, collection: Post.all.map { |p| [p.id.to_s] }

  show do |comment|
    attributes_table do
      row :id
      row :user
      row :post_id
      row 'Text' do
        markdown comment.text
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :post, collection: Post.all.map { |p| [p.id.to_s] }
      f.input :text
    end

    f.actions
  end
end
