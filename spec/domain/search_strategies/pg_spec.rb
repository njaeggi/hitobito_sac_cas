#  Copyright (c) 2012-2024, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas.

require 'spec_helper'

describe SearchStrategies::Pg do

  before do
    @bg_leader = Fabricate(Group::BottomGroup::Leader.name.to_sym,
                           group: groups(:bottom_group_one_one),
                           person: Fabricate(:person, last_name: 'Schurter', first_name: 'Franz')).person

    # id has to be long enough
    @bg_leader.update(id: 123456789)
  end

  describe '#query_people' do
    let(:user) { people(:top_leader) }

    it 'finds accessible person by id' do
        result = strategy(@bg_leader.id.to_s).query_people

        expect(result).to include(@bg_leader)
    end
  end

  def strategy(term = nil, page = nil)
    SearchStrategies::Pg.new(user, term, page)
  end

end
