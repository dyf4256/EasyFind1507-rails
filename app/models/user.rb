class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_favoritor

  has_many :recommendations
  has_many :accepted_recommendations, -> { where status: 2 }, class_name: 'Recommendation', foreign_key: :user_id
  has_many :favourited_recommendations, -> { where status: 3 }, class_name: 'Recommendation', foreign_key: :user_id
  has_many :movies, through: :recommendations, source_type: "Movie", source: :activity
  has_many :attractions, through: :recommendations, source_type: "Attraction", source: :activity
  has_many :events, through: :recommendations, source_type: "Event", source: :activity
  has_many :restaurants, through: :recommendations, source_type: "Restaurant", source: :activity

  def activities_accepted
    accepted_recommendations.map(&:activity)
  end

  def activities_favourited
    favourited_recommendations.map(&:activity)
  end
end
