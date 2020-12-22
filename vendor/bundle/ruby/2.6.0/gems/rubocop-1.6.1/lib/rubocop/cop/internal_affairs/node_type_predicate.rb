# frozen_string_literal: true

module RuboCop
  module Cop
    module InternalAffairs
      # Checks that node types are checked using the predicate helpers.
      #
      # @example
      #
      #   # bad
      #   node.type == :send
      #
      #   # good
      #   node.send_type?
      #
      class NodeTypePredicate < Base
        extend AutoCorrector

        MSG = 'Use `#%<type>s_type?` to check node type.'
        RESTRICT_ON_SEND = %i[==].freeze

        def_node_matcher :node_type_check, <<~PATTERN
          (send (send $_ :type) :== (sym $_))
        PATTERN

        def on_send(node)
          node_type_check(node) do |receiver, node_type|
            return unless Parser::Meta::NODE_TYPES.include?(node_type)

            message = format(MSG, type: node_type)
            add_offense(node, message: message) do |corrector|
              range = node.loc.expression.with(
                begin_pos: receiver.loc.expression.end_pos + 1
              )
              corrector.replace(range, "#{node_type}_type?")
            end
          end
        end
      end
    end
  end
end
