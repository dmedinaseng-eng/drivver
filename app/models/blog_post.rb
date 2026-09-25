class BlogPost < ApplicationRecord
  belongs_to :organization
  belongs_to :author, class_name: "User"
end
