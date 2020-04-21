class Resource < ApplicationRecord
  validate :presence

  def presence
    errors.add(:base, 'name') if name.blank?
    errors.add(:base, 'link') if url.blank?
  end
end
