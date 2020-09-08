class UserPlaylist < ActiveRecord::Base
  belongs_to :user
  belongs_to :playlist

  def rate_playlist
    rate = gets.chomp
    self.rating = rate
  end

  def display_rating
    if self.rating == nil
      puts "not rated"
    else
      puts self.rating
    end
  end

end
