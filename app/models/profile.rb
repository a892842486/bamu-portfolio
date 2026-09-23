class Profile < ApplicationRecord
    has_many :links, as: :linkable, dependent: :destroy

    accepts_nested_attributes_for :links, allow_destroy: true

    validates :display_name, presence: true
    validates :job_title, presence: true
    validates :introduction, presence: true
    validates :contact_email, presence: true
end
