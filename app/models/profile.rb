class Profile < ApplicationRecord
  enum theme: { default: 0, leerob: 1 }, _suffix: true

  belongs_to :user
  has_one :github, dependent: :destroy
  has_many :projects, dependent: :destroy

  after_initialize :set_defaults

  validates_each :social_links do |record, attr, value|
    value_dup = value.symbolize_keys
    valid_socials_hash = valid_socials

    value_dup.each_key do |k|
      unless valid_socials_hash.include?(k)
        record.errors.add(attr, "#{k} is not a valid social provider")
      end
    end
  end

  validates :projects, length: { maximum: 5 }

  def set_defaults
    return unless new_record?

    self.tagline ||= ''
    self.social_links ||= {}
  end

  # class method for valid social providers (valid keys for social_links)
  def self.valid_socials
    %i[twitter facebook github stackoverflow dribble devto linkedin]
  end

  # base urls for user profiles for each provider
  # prepend 'https://' and append username/user-id to get full url
  def self.base_social_links
    {
      linkedin: 'linkedin.com/in/',
      devto: 'dev.to/',
      stackoverflow: 'stackoverflow.com/users/',
      dribbble: 'dribbble.com/',
      facebook: 'facebook.com/',
      twitter: 'twitter.com/',
      github: 'github.com/'
    }
  end

  def self.valid_themes
    themes.keys
  end
end
