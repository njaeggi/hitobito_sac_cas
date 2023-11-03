# frozen_string_literal: true

#  Copyright (c) 2023, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas.

require 'spec_helper'

describe Export::Tabular::People::WithSacAdditions do

  let(:group) { groups(:bluemlisalp_mitglieder) }
  let(:person) { Fabricate(:person, household_key: 'F1234', birthday: 25.years.ago, primary_group: group) }

  shared_examples 'has membership_number' do

    it 'prepends WithMembershipNumber' do
      expect(tabular_class.ancestors).to include Export::Tabular::People::WithSacAdditions

      expect(tabular_class.ancestors.index(Export::Tabular::People::WithSacAdditions)).
        to be < tabular_class.ancestors.index(tabular_class)
    end

    subject { tabular_class.new([tabular_entry]) }
    let(:row) { subject.attributes.zip(subject.data_rows.first).to_h }

    it 'has the additonal sac headers' do
      expect(subject.attributes).to include :membership_number, :family_id
    end

    context 'membership_number' do
      it 'has the correct label' do
        expect(subject.attribute_labels[:membership_number]).to eq 'Mitglied-Nr'
      end

      it 'has the correct value' do
        expect(row[:membership_number]).to eq person.membership_number
      end
    end

    context 'family_key' do
      it 'has the correct label' do
        expect(subject.attribute_labels[:family_id]).to eq 'Familien ID'
      end

      it 'has blank value for person without beitragskategorie=familie' do
        assert(person.roles.empty?)
        expect(row[:family_id]).to be_nil
      end

      it 'has value from household_key for person with beitragskategorie=familie' do
        Fabricate(Group::SektionsMitglieder::Mitglied.name.to_sym, group: group, person: person)
        expect(row[:family_id]).to eq person.household_key
      end
    end

  end

  [
    Export::Tabular::People::Households,
    Export::Tabular::People::PeopleAddress,
    Export::Tabular::People::PeopleFull
  ].each do |tabular_class|

    describe tabular_class do
      let(:tabular_class) { tabular_class }
      let(:tabular_entry) { person }

      it_behaves_like 'has membership_number'
    end

  end

  [
    Export::Tabular::People::ParticipationsFull,
    Export::Tabular::People::ParticipationsHouseholds
  ].each do |tabular_class|

    describe tabular_class do
      let(:tabular_class) { tabular_class }
      let(:tabular_entry) { Fabricate(:event_participation, person: person) }

      it_behaves_like 'has membership_number'
    end
  end
end
