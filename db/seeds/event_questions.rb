# frozen_string_literal: true

#  Copyright (c) 2012-2024, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas.

# recreate default event questions
questions_data = [
  { question: 'Notfallkontakt 1 - Name und Telefonnummer', required: true, },
  { question: 'Notfallkontakt 2 - Name und Telefonnummer', required: true, },
]

unless Event::Question.where(question: questions_data.pluck(:question)).count == 2
  # delete all default event questions first
  Event::Question.where(event_id: nil).destroy_all


  questions_data.each do |attrs|
    eq = Event::Question.find_or_initialize_by(
      event_id: attrs.delete(:event_id),
      question: attrs.delete(:question)
    )
    eq.attributes = attrs
    eq.save!
  end
end
