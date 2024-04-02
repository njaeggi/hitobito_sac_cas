# frozen_string_literal: true

#  Copyright (c) 2024, Schweizer Alpen-Club. This file is part of
#  hitobito_sac_cas and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sac_cas

class Invoice
  module Abacus
    class Invoice < Entity

      def create
        create_sales_order
        create_sales_order_positions
      end

      def fetch
        client.get(:sales_order, entity.abacus_key, '$expand' => 'Positions')
      end

      def create_sales_order
        data = client.create(:sales_order, sales_order_attrs)
        # abacus_key attribute is yet missing on invoice. This is a hash with the two following keys
        entity.abacus_key = data.slice(:sales_order_id, :sales_order_backlog_id)
      end

      def create_sales_order_positions
        entity.invoice_items.list.each_with_index do |item, index|
          client.create(:sales_order_position, sales_order_position_attrs(item, index + 1))
        end
      end

      def sales_order_attrs
        {
          customer_subject_id: entity.recipient.abacus_key, # abacus_key attribute is yet missing on person
          order_date: entity.issued_at,
          delivery_date: entity.sent_at,
          total_amount: entity.total.to_f
        }
      end

      def sales_order_position_attrs(item, position)
        {
          sales_order_id: sales_order_id,
          position_number: position,
          amount: { total_including_tax: item.total.to_f },
          quantity: { charged: item.count },
          product: { description: item.name, product_number: 'a0' }
        }
      end

      def sales_order_id
        entity.abacus_key.fetch(:sales_order_id)
      end
    end
  end
end
