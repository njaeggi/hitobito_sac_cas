# frozen_string_literal: true

#  Copyright (c) 2012-2023, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas.

class SelfRegistrationAbo::MainPerson < SelfRegistrationAbo::Person
  MIN_YEARS = 18

  self.attrs = [
    :first_name, :last_name, :email, :gender, :birthday,
    :address, :zip_code, :town, :country,
    :number,
    :primary_group
  ]

  self.required_attrs = [
    :first_name, :last_name, :email, :address, :zip_code, :town, :birthday, :country, :number
  ]

  validate :assert_old_enough, if: -> { person.years }

  private

  def assert_old_enough
    errors.add(:base, :must_be_older_than_18) if person.years < MIN_YEARS
  end
end