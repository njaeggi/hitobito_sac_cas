# frozen_string_literal: true

#  Copyright (c) 2024, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas.

module SacCas::Qualification
  extend ActiveSupport::Concern

  included do
    before_validation :set_finish_at, unless: :finish_at
  end

  def finish_at_manually_editable?
    qualification_kind.finish_at_manually_editable?
  end

end
