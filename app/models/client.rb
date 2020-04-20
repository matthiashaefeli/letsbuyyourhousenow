class Client < ApplicationRecord
  validate :validate_names
  validate :email_or_tel
  validate :validate_email

  def validate_email
    errors.add(:base, 'email') if email.length > 0 && (email =~ /^.+@.+$/).nil?
  end

  def validate_names
    errors.add(:base, 'first_name') if first_name.blank?
    errors.add(:base, 'last_name') if last_name.blank?
  end

  def email_or_tel
    if email.blank? && tel.blank?
      errors.add(:base, 'email_or_tel')
    end
  end
end
