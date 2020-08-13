# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :first_name, :last_name, :username, :description, :gender, :birth_date, :email,
                :password, :password_confirmation

  index do
    selectable_column
    column :id do |user|
      user.id.truncate 11
    end
    column :name do |user|
      "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    end
    column :username
    column :gender
    column :birth_date
    column :email
    column :created_at
    column :updated_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :username
  filter :gender
  filter :birth_date
  filter :created_at
  filter :updated_at

  show do |user|
    attributes_table do
      row :id
      row :avatar do
        link_to 'Image', url_for(user.avatar), target: :blank if user.avatar.attached?
      end
      row :first_name
      row :last_name
      row :username
      row 'Description' do
        markdown user.description if user.description.present?
      end
      row :gender
      row :birth_date
      row :email
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :description
      f.input :gender
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
end
