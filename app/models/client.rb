class Client < ApplicationRecord
  validate :validate_names
  validate :email_or_tel
  validate :validate_tel_zip
  validate :validate_email

  def validate_email
    errors.add(:base, 'Please add a valid email address') if (email =~ /^.+@.+$/).nil?
  end

  def validate_names
    errors.add(:base, 'Please add a First Name') if first_name.blank?
    errors.add(:base, 'Please add a Last Name') if last_name.blank?
  end

  def email_or_tel
    if email.blank? && tel.blank?
      errors.add(:base, 'Please add Email or Tel')
    end
  end

  def validate_tel_zip
    if !tel.blank?
      errors.add(:base, 'Tel can only have numbers') unless tel > 0
    end
    if !zip.blank?
      errors.add(:base, 'Zip can only have numbers') unless zip > 0
    end
  end
end
