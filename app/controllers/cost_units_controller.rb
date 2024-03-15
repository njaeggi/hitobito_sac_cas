# frozen_string_literal: true

#  Copyright (c) 2024, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas

class CostUnitsController < SimpleCrudController
  self.permitted_attrs = [:code, :label]

  private

  def list_entries
    super.list
  end
end
