class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_favoritor

  has_many :sessions
  has_many :recommendations, through: :sessions
  has_many :accepted_recommendations, through: :sessions, source: :accepted_recommendation
  has_many :bookmarked_recommendations, through: :sessions, source: :bookmarked_recommendations
  has_many :movies, through: :recommendations, source_type: "Movie", source: :activity
  has_many :attractions, through: :recommendations, source_type: "Attraction", source: :activity
  has_many :events, through: :recommendations, source_type: "Event", source: :activity
  has_many :restaurants, through: :recommendations, source_type: "Restaurant", source: :activity

  def accepted_activities
    accepted_recommendations.includes(:activity).map(&:activity)
  end

  def bookmarked_activities
    bookmarked_recommendations.includes(:activity).map(&:activity)
  end

  def favorited_activities
    all_favorited
  end

  def favorited_recommendations
    all_favorites.includes(:favoritable)
  end
end
