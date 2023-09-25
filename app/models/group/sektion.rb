# frozen_string_literal: true

#  Copyright (c) 2012-2023, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas.

class Group::Sektion < ::Group

  self.layer = true
  self.event_types = [Event, Event::Course]

  ### ROLES

  children Group::SektionsFunktionaere,
    Group::SektionsMitglieder,
    Group::SektionsNeuMitgliederSektion,
    Group::SektionsNeuMitgliederZv,
    Group::SektionsTourenkommission,
    Group::Huette,
    Group::Ortsgruppe

  mounted_attr :foundation_year, :integer
  validates :foundation_year, numericality: { greater_than: 1863, smaller_than: Time.zone.now.year + 2 }

end
