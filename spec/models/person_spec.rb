# frozen_string_literal: true

#  Copyright (c) 2012-2023, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas.

require 'spec_helper'

describe Person do
  context '#membership_number (id)' do
    it 'is generated automatically' do
      person = Person.create!(first_name: 'John')
      expect(person.membership_number).to be_present
    end

    it 'cannot be changed' do
      person = Person.create!(first_name: 'John')
      person.membership_number = 42
      person.save!

      expect(Person.exists?(42)).to eq(false)
    end

    it 'cannot be set for new records' do
      person = Person.create!(first_name: 'John', membership_number: 123123)

      expect(600_000..600_500).to include(person.membership_number)
    end

    it 'can be set for new records with Person.allow_manual_id' do
      person = Person.with_manual_membership_number do
        Person.create!(first_name: 'John', membership_number: 123123)
      end
      expect(person.reload.id).to eq 123123
    end

    it 'must be unique' do
      Person.with_manual_membership_number do
        Person.create!(first_name: 'John', membership_number: 123123)
        expect { Person.create!(first_name: 'John', membership_number: 123123) }.
          to raise_error(ActiveRecord::RecordNotUnique, /Duplicate entry/)
      end
    end
  end
end