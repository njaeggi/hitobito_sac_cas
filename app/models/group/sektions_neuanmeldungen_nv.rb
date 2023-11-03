# frozen_string_literal: true

#  Copyright (c) 2012-2023, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas.

class Group::SektionsNeuanmeldungenNv < ::Group

  self.static_name = true

  ### ROLES
  class Neuanmeldung < ::Role
    include ::SacCas::RoleBeitragskategorie

    self.permissions = []
    self.basic_permissions_only = true

    def convert!
      Role.transaction do
        target_group = group.parent.children.find_by!(type: Group::SektionsMitglieder)
        target_group.roles.create!(person: person, type: Group::SektionsMitglieder::Mitglied.sti_name, beitragskategorie: beitragskategorie)
        destroy!
      end
    end
  end

  roles Neuanmeldung
end
