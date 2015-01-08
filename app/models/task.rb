class Task < ActiveRecord::Base
	validates :user_id,presence: true
	validates :description, presence: true
	validates :status, presence: true
end
