# frozen_string_literal: true

#  Copyright (c) 2024, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.
#
# == Schema Information
#
# Table name: event_kinds
#
#  id                     :integer          not null, primary key
#  accommodation          :string(255)      default("no_overnight"), not null
#  application_conditions :text(65535)
#  deleted_at             :datetime
#  general_information    :text(65535)
#  kurs_id_fiver          :string(255)
#  maximum_participants   :integer
#  minimum_age            :integer
#  minimum_participants   :integer
#  reserve_accommodation  :boolean          default(TRUE), not null
#  season                 :string(255)
#  short_name             :string(255)
#  training_days          :decimal(5, 2)
#  vereinbarungs_id_fiver :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  cost_center_id         :bigint           not null
#  cost_unit_id           :bigint           not null
#  kind_category_id       :integer
#  level_id               :bigint           not null
#
# Indexes
#
#  index_event_kinds_on_cost_center_id  (cost_center_id)
#  index_event_kinds_on_cost_unit_id    (cost_unit_id)
#  index_event_kinds_on_level_id        (level_id)
#

require 'spec_helper'

describe Event::Kind do
  describe '::validations' do
    subject(:kind) { Fabricate.build(:sac_event_kind) }

    it 'is valid as builded by fabricator' do
      expect(kind).to be_valid
      expect(kind.level).to eq event_levels(:ek)
    end

    it 'validates presence of short_name' do
      kind.short_name = nil
      expect(kind).not_to be_valid
      expect(kind.errors[:short_name]).to eq ['muss ausgefüllt werden']
    end

    it 'validates presence of category' do
      kind.kind_category = nil
      expect(kind).not_to be_valid
      expect(kind.errors[:kind_category]).to eq ['muss ausgefüllt werden']
    end

    it 'validates presence of cost_center' do
      kind.cost_center_id = nil
      expect(kind).not_to be_valid
      expect(kind.errors[:cost_center_id]).to eq ['muss ausgefüllt werden']
    end

    it 'validates presence of cost_unit' do
      kind.cost_unit_id = nil
      expect(kind).not_to be_valid
      expect(kind.errors[:cost_unit_id]).to eq ['muss ausgefüllt werden']
    end
  end

  describe '#push_inherited_attributes_to_courses!' do
    let(:course) { events(:top_course) }
    let(:kind) { event_kinds(:ski_course) }
    let(:kind_attrs) {
      {
        application_conditions: 'test',
        minimum_age: 1,
        minimum_participants: 2,
        maximum_participants: 3,
        training_days: 4,
        season: 'winter',
        reserve_accommodation: true,
        accommodation: 'hut',
        reserve_accommodation: false,
        cost_center_id: 1,
        cost_unit_id: 1
      }
    }

    before do
      kind.attributes = kind_attrs
      kind.save!
    end

    def read_course_attrs
      course.reload.attributes.symbolize_keys.slice(*kind_attrs.keys)
    end

    def with_locales(locales = %w(de fr))
      locales.each { |l| I18n.with_locale(l) { yield(l) } }
    end

    it 'updates course attributes' do
      expect do
        kind.push_inherited_attributes_to_courses!
      end.to change { read_course_attrs }.to(kind_attrs)
    end

    it 'updates translated application_conditions column' do
      with_locales do |l|
        kind.label = l
        kind.application_conditions = l
      end

      kind.save!
      expect { kind.push_inherited_attributes_to_courses! }.to change { course.translations.count }.by(1)
      I18n.with_locale('de') { expect(course.application_conditions).to eq 'de' }
      I18n.with_locale('fr') { expect(course.application_conditions).to eq 'fr' }
    end

    it 'does not update existing values with blanks' do
      kind.update!(minimum_age: nil)
      course.update!(minimum_age: 12)

      expect do
        kind.push_inherited_attributes_to_courses!
      end.not_to change { course.reload.minimum_age }
    end

    it 'noops if course state is ignored' do
      %w(completed canceled).each do |state|
        course.update!(state: state)
        expect do
          kind.push_inherited_attributes_to_courses!
        end.not_to change { read_course_attrs }
      end
    end

    it 'noops when course is not associated with kind' do
      course.update_columns(kind_id: -1)
      expect { kind.push_inherited_attributes_to_courses! }.not_to change  { read_course_attrs }
    end
  end
end
