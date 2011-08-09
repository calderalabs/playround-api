class Quicktour < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user_id
  
  GUIDERS =
    [{
      :title => I18n.t('quicktour.welcome.title'),
      :description => I18n.t('quicktour.welcome.description'),
      :next => I18n.t('quicktour.next'),
      :overlay => true,
      :close => I18n.t('quicktour.no_thanks')
    },
    {
      :title => I18n.t('quicktour.location.title'),
      :description => I18n.t('quicktour.location.description'),
      :attach => "update-location-link",
      :next => I18n.t('quicktour.next')
    },
    {
      :title => I18n.t('quicktour.profile.title'),
      :description => I18n.t('quicktour.profile.description'),
      :attach => "update-profile-link",
      :next => I18n.t('quicktour.next')
    },
    {
      :title => I18n.t('quicktour.rounds.title'),
      :description => I18n.t('quicktour.rounds.description'),
      :attach => "rounds-nav",
      :next => I18n.t('quicktour.next')
    },
    {
      :title => I18n.t('quicktour.arenas.title'),
      :description => I18n.t('quicktour.arenas.description'),
      :attach => "arenas-nav",
      :close => I18n.t('quicktour.close')
    }]    

  def next!
    self.current_guider += 1
    self.save
  end
  
  validates_numericality_of :current_guider, :less_than => Proc.new { GUIDERS.count }, :greater_than_or_equal_to => 0, :only_integer => true
end
