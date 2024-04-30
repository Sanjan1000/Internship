# frozen_string_literal: true

=begin
This file is generated by the templates/template.rb script and should not be
modified manually. See templates/lib/prism/reflection.rb.erb
if you are looking to modify the template
=end

module Prism
  # The Reflection module provides the ability to reflect on the structure of
  # the syntax tree itself, as opposed to looking at a single syntax tree. This
  # is useful in metaprogramming contexts.
  module Reflection
    # A field represents a single piece of data on a node. It is the base class
    # for all other field types.
    class Field
      # The name of the field.
      attr_reader :name

      # Initializes the field with the given name.
      def initialize(name)
        @name = name
      end
    end

    # A node field represents a single child node in the syntax tree. It
    # resolves to a Prism::Node in Ruby.
    class NodeField < Field
    end

    # An optional node field represents a single child node in the syntax tree
    # that may or may not be present. It resolves to either a Prism::Node or nil
    # in Ruby.
    class OptionalNodeField < Field
    end

    # A node list field represents a list of child nodes in the syntax tree. It
    # resolves to an array of Prism::Node instances in Ruby.
    class NodeListField < Field
    end

    # A constant field represents a constant value on a node. Effectively, it
    # represents an identifier found within the source. It resolves to a symbol
    # in Ruby.
    class ConstantField < Field
    end

    # An optional constant field represents a constant value on a node that may
    # or may not be present. It resolves to either a symbol or nil in Ruby.
    class OptionalConstantField < Field
    end

    # A constant list field represents a list of constant values on a node. It
    # resolves to an array of symbols in Ruby.
    class ConstantListField < Field
    end

    # A string field represents a string value on a node. It almost always
    # represents the unescaped value of a string-like literal. It resolves to a
    # string in Ruby.
    class StringField < Field
    end

    # A location field represents the location of some part of the node in the
    # source code. For example, the location of a keyword or an operator. It
    # resolves to a Prism::Location in Ruby.
    class LocationField < Field
    end

    # An optional location field represents the location of some part of the
    # node in the source code that may or may not be present. It resolves to
    # either a Prism::Location or nil in Ruby.
    class OptionalLocationField < Field
    end

    # An integer field represents an integer value. It is used to represent the
    # value of an integer literal, the depth of local variables, and the number
    # of a numbered reference. It resolves to an Integer in Ruby.
    class IntegerField < Field
    end

    # A float field represents a double-precision floating point value. It is
    # used exclusively to represent the value of a floating point literal. It
    # resolves to a Float in Ruby.
    class FloatField < Field
    end

    # A flags field represents a bitset of flags on a node. It resolves to an
    # integer in Ruby. Note that the flags cannot be accessed directly on the
    # node because the integer is kept private. Instead, the various flags in
    # the bitset should be accessed through their query methods.
    class FlagsField < Field
      # The names of the flags in the bitset.
      attr_reader :flags

      # Initializes the flags field with the given name and flags.
      def initialize(name, flags)
        super(name)
        @flags = flags
      end
    end

    # Returns the fields for the given node.
    def self.fields_for(node)
      case node.type
      when :alias_global_variable_node
        [NodeField.new(:new_name), NodeField.new(:old_name), LocationField.new(:keyword_loc)]
      when :alias_method_node
        [NodeField.new(:new_name), NodeField.new(:old_name), LocationField.new(:keyword_loc)]
      when :alternation_pattern_node
        [NodeField.new(:left), NodeField.new(:right), LocationField.new(:operator_loc)]
      when :and_node
        [NodeField.new(:left), NodeField.new(:right), LocationField.new(:operator_loc)]
      when :arguments_node
        [FlagsField.new(:flags, [:contains_keyword_splat?]), NodeListField.new(:arguments)]
      when :array_node
        [FlagsField.new(:flags, [:contains_splat?]), NodeListField.new(:elements), OptionalLocationField.new(:opening_loc), OptionalLocationField.new(:closing_loc)]
      when :array_pattern_node
        [OptionalNodeField.new(:constant), NodeListField.new(:requireds), OptionalNodeField.new(:rest), NodeListField.new(:posts), OptionalLocationField.new(:opening_loc), OptionalLocationField.new(:closing_loc)]
      when :assoc_node
        [NodeField.new(:key), NodeField.new(:value), OptionalLocationField.new(:operator_loc)]
      when :assoc_splat_node
        [OptionalNodeField.new(:value), LocationField.new(:operator_loc)]
      when :back_reference_read_node
        [ConstantField.new(:name)]
      when :begin_node
        [OptionalLocationField.new(:begin_keyword_loc), OptionalNodeField.new(:statements), OptionalNodeField.new(:rescue_clause), OptionalNodeField.new(:else_clause), OptionalNodeField.new(:ensure_clause), OptionalLocationField.new(:end_keyword_loc)]
      when :block_argument_node
        [OptionalNodeField.new(:expression), LocationField.new(:operator_loc)]
      when :block_local_variable_node
        [FlagsField.new(:flags, [:repeated_parameter?]), ConstantField.new(:name)]
      when :block_node
        [ConstantListField.new(:locals), OptionalNodeField.new(:parameters), OptionalNodeField.new(:body), LocationField.new(:opening_loc), LocationField.new(:closing_loc)]
      when :block_parameter_node
        [FlagsField.new(:flags, [:repeated_parameter?]), OptionalConstantField.new(:name), OptionalLocationField.new(:name_loc), LocationField.new(:operator_loc)]
      when :block_parameters_node
        [OptionalNodeField.new(:parameters), NodeListField.new(:locals), OptionalLocationField.new(:opening_loc), OptionalLocationField.new(:closing_loc)]
      when :break_node
        [OptionalNodeField.new(:arguments), LocationField.new(:keyword_loc)]
      when :call_and_write_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), OptionalNodeField.new(:receiver), OptionalLocationField.new(:call_operator_loc), OptionalLocationField.new(:message_loc), ConstantField.new(:read_name), ConstantField.new(:write_name), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :call_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), OptionalNodeField.new(:receiver), OptionalLocationField.new(:call_operator_loc), ConstantField.new(:name), OptionalLocationField.new(:message_loc), OptionalLocationField.new(:opening_loc), OptionalNodeField.new(:arguments), OptionalLocationField.new(:closing_loc), OptionalNodeField.new(:block)]
      when :call_operator_write_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), OptionalNodeField.new(:receiver), OptionalLocationField.new(:call_operator_loc), OptionalLocationField.new(:message_loc), ConstantField.new(:read_name), ConstantField.new(:write_name), ConstantField.new(:operator), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :call_or_write_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), OptionalNodeField.new(:receiver), OptionalLocationField.new(:call_operator_loc), OptionalLocationField.new(:message_loc), ConstantField.new(:read_name), ConstantField.new(:write_name), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :call_target_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), NodeField.new(:receiver), LocationField.new(:call_operator_loc), ConstantField.new(:name), LocationField.new(:message_loc)]
      when :capture_pattern_node
        [NodeField.new(:value), NodeField.new(:target), LocationField.new(:operator_loc)]
      when :case_match_node
        [OptionalNodeField.new(:predicate), NodeListField.new(:conditions), OptionalNodeField.new(:consequent), LocationField.new(:case_keyword_loc), LocationField.new(:end_keyword_loc)]
      when :case_node
        [OptionalNodeField.new(:predicate), NodeListField.new(:conditions), OptionalNodeField.new(:consequent), LocationField.new(:case_keyword_loc), LocationField.new(:end_keyword_loc)]
      when :class_node
        [ConstantListField.new(:locals), LocationField.new(:class_keyword_loc), NodeField.new(:constant_path), OptionalLocationField.new(:inheritance_operator_loc), OptionalNodeField.new(:superclass), OptionalNodeField.new(:body), LocationField.new(:end_keyword_loc), ConstantField.new(:name)]
      when :class_variable_and_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :class_variable_operator_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value), ConstantField.new(:operator)]
      when :class_variable_or_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :class_variable_read_node
        [ConstantField.new(:name)]
      when :class_variable_target_node
        [ConstantField.new(:name)]
      when :class_variable_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), NodeField.new(:value), LocationField.new(:operator_loc)]
      when :constant_and_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :constant_operator_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value), ConstantField.new(:operator)]
      when :constant_or_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :constant_path_and_write_node
        [NodeField.new(:target), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :constant_path_node
        [OptionalNodeField.new(:parent), NodeField.new(:child), LocationField.new(:delimiter_loc)]
      when :constant_path_operator_write_node
        [NodeField.new(:target), LocationField.new(:operator_loc), NodeField.new(:value), ConstantField.new(:operator)]
      when :constant_path_or_write_node
        [NodeField.new(:target), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :constant_path_target_node
        [OptionalNodeField.new(:parent), NodeField.new(:child), LocationField.new(:delimiter_loc)]
      when :constant_path_write_node
        [NodeField.new(:target), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :constant_read_node
        [ConstantField.new(:name)]
      when :constant_target_node
        [ConstantField.new(:name)]
      when :constant_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), NodeField.new(:value), LocationField.new(:operator_loc)]
      when :def_node
        [ConstantField.new(:name), LocationField.new(:name_loc), OptionalNodeField.new(:receiver), OptionalNodeField.new(:parameters), OptionalNodeField.new(:body), ConstantListField.new(:locals), LocationField.new(:def_keyword_loc), OptionalLocationField.new(:operator_loc), OptionalLocationField.new(:lparen_loc), OptionalLocationField.new(:rparen_loc), OptionalLocationField.new(:equal_loc), OptionalLocationField.new(:end_keyword_loc)]
      when :defined_node
        [OptionalLocationField.new(:lparen_loc), NodeField.new(:value), OptionalLocationField.new(:rparen_loc), LocationField.new(:keyword_loc)]
      when :else_node
        [LocationField.new(:else_keyword_loc), OptionalNodeField.new(:statements), OptionalLocationField.new(:end_keyword_loc)]
      when :embedded_statements_node
        [LocationField.new(:opening_loc), OptionalNodeField.new(:statements), LocationField.new(:closing_loc)]
      when :embedded_variable_node
        [LocationField.new(:operator_loc), NodeField.new(:variable)]
      when :ensure_node
        [LocationField.new(:ensure_keyword_loc), OptionalNodeField.new(:statements), LocationField.new(:end_keyword_loc)]
      when :false_node
        []
      when :find_pattern_node
        [OptionalNodeField.new(:constant), NodeField.new(:left), NodeListField.new(:requireds), NodeField.new(:right), OptionalLocationField.new(:opening_loc), OptionalLocationField.new(:closing_loc)]
      when :flip_flop_node
        [FlagsField.new(:flags, [:exclude_end?]), OptionalNodeField.new(:left), OptionalNodeField.new(:right), LocationField.new(:operator_loc)]
      when :float_node
        [FloatField.new(:value)]
      when :for_node
        [NodeField.new(:index), NodeField.new(:collection), OptionalNodeField.new(:statements), LocationField.new(:for_keyword_loc), LocationField.new(:in_keyword_loc), OptionalLocationField.new(:do_keyword_loc), LocationField.new(:end_keyword_loc)]
      when :forwarding_arguments_node
        []
      when :forwarding_parameter_node
        []
      when :forwarding_super_node
        [OptionalNodeField.new(:block)]
      when :global_variable_and_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :global_variable_operator_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value), ConstantField.new(:operator)]
      when :global_variable_or_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :global_variable_read_node
        [ConstantField.new(:name)]
      when :global_variable_target_node
        [ConstantField.new(:name)]
      when :global_variable_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), NodeField.new(:value), LocationField.new(:operator_loc)]
      when :hash_node
        [LocationField.new(:opening_loc), NodeListField.new(:elements), LocationField.new(:closing_loc)]
      when :hash_pattern_node
        [OptionalNodeField.new(:constant), NodeListField.new(:elements), OptionalNodeField.new(:rest), OptionalLocationField.new(:opening_loc), OptionalLocationField.new(:closing_loc)]
      when :if_node
        [OptionalLocationField.new(:if_keyword_loc), NodeField.new(:predicate), OptionalLocationField.new(:then_keyword_loc), OptionalNodeField.new(:statements), OptionalNodeField.new(:consequent), OptionalLocationField.new(:end_keyword_loc)]
      when :imaginary_node
        [NodeField.new(:numeric)]
      when :implicit_node
        [NodeField.new(:value)]
      when :implicit_rest_node
        []
      when :in_node
        [NodeField.new(:pattern), OptionalNodeField.new(:statements), LocationField.new(:in_loc), OptionalLocationField.new(:then_loc)]
      when :index_and_write_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), OptionalNodeField.new(:receiver), OptionalLocationField.new(:call_operator_loc), LocationField.new(:opening_loc), OptionalNodeField.new(:arguments), LocationField.new(:closing_loc), OptionalNodeField.new(:block), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :index_operator_write_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), OptionalNodeField.new(:receiver), OptionalLocationField.new(:call_operator_loc), LocationField.new(:opening_loc), OptionalNodeField.new(:arguments), LocationField.new(:closing_loc), OptionalNodeField.new(:block), ConstantField.new(:operator), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :index_or_write_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), OptionalNodeField.new(:receiver), OptionalLocationField.new(:call_operator_loc), LocationField.new(:opening_loc), OptionalNodeField.new(:arguments), LocationField.new(:closing_loc), OptionalNodeField.new(:block), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :index_target_node
        [FlagsField.new(:flags, [:safe_navigation?, :variable_call?, :attribute_write?, :ignore_visibility?]), NodeField.new(:receiver), LocationField.new(:opening_loc), OptionalNodeField.new(:arguments), LocationField.new(:closing_loc), OptionalNodeField.new(:block)]
      when :instance_variable_and_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :instance_variable_operator_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value), ConstantField.new(:operator)]
      when :instance_variable_or_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :instance_variable_read_node
        [ConstantField.new(:name)]
      when :instance_variable_target_node
        [ConstantField.new(:name)]
      when :instance_variable_write_node
        [ConstantField.new(:name), LocationField.new(:name_loc), NodeField.new(:value), LocationField.new(:operator_loc)]
      when :integer_node
        [FlagsField.new(:flags, [:binary?, :decimal?, :octal?, :hexadecimal?]), Integer.new(:value)]
      when :interpolated_match_last_line_node
        [FlagsField.new(:flags, [:ignore_case?, :extended?, :multi_line?, :once?, :euc_jp?, :ascii_8bit?, :windows_31j?, :utf_8?, :forced_utf8_encoding?, :forced_binary_encoding?, :forced_us_ascii_encoding?]), LocationField.new(:opening_loc), NodeListField.new(:parts), LocationField.new(:closing_loc)]
      when :interpolated_regular_expression_node
        [FlagsField.new(:flags, [:ignore_case?, :extended?, :multi_line?, :once?, :euc_jp?, :ascii_8bit?, :windows_31j?, :utf_8?, :forced_utf8_encoding?, :forced_binary_encoding?, :forced_us_ascii_encoding?]), LocationField.new(:opening_loc), NodeListField.new(:parts), LocationField.new(:closing_loc)]
      when :interpolated_string_node
        [FlagsField.new(:flags, [:frozen?, :mutable?]), OptionalLocationField.new(:opening_loc), NodeListField.new(:parts), OptionalLocationField.new(:closing_loc)]
      when :interpolated_symbol_node
        [OptionalLocationField.new(:opening_loc), NodeListField.new(:parts), OptionalLocationField.new(:closing_loc)]
      when :interpolated_x_string_node
        [LocationField.new(:opening_loc), NodeListField.new(:parts), LocationField.new(:closing_loc)]
      when :it_parameters_node
        []
      when :keyword_hash_node
        [FlagsField.new(:flags, [:symbol_keys?]), NodeListField.new(:elements)]
      when :keyword_rest_parameter_node
        [FlagsField.new(:flags, [:repeated_parameter?]), OptionalConstantField.new(:name), OptionalLocationField.new(:name_loc), LocationField.new(:operator_loc)]
      when :lambda_node
        [ConstantListField.new(:locals), LocationField.new(:operator_loc), LocationField.new(:opening_loc), LocationField.new(:closing_loc), OptionalNodeField.new(:parameters), OptionalNodeField.new(:body)]
      when :local_variable_and_write_node
        [LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value), ConstantField.new(:name), Integer.new(:depth)]
      when :local_variable_operator_write_node
        [LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value), ConstantField.new(:name), ConstantField.new(:operator), Integer.new(:depth)]
      when :local_variable_or_write_node
        [LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value), ConstantField.new(:name), Integer.new(:depth)]
      when :local_variable_read_node
        [ConstantField.new(:name), Integer.new(:depth)]
      when :local_variable_target_node
        [ConstantField.new(:name), Integer.new(:depth)]
      when :local_variable_write_node
        [ConstantField.new(:name), Integer.new(:depth), LocationField.new(:name_loc), NodeField.new(:value), LocationField.new(:operator_loc)]
      when :match_last_line_node
        [FlagsField.new(:flags, [:ignore_case?, :extended?, :multi_line?, :once?, :euc_jp?, :ascii_8bit?, :windows_31j?, :utf_8?, :forced_utf8_encoding?, :forced_binary_encoding?, :forced_us_ascii_encoding?]), LocationField.new(:opening_loc), LocationField.new(:content_loc), LocationField.new(:closing_loc), StringField.new(:unescaped)]
      when :match_predicate_node
        [NodeField.new(:value), NodeField.new(:pattern), LocationField.new(:operator_loc)]
      when :match_required_node
        [NodeField.new(:value), NodeField.new(:pattern), LocationField.new(:operator_loc)]
      when :match_write_node
        [NodeField.new(:call), NodeListField.new(:targets)]
      when :missing_node
        []
      when :module_node
        [ConstantListField.new(:locals), LocationField.new(:module_keyword_loc), NodeField.new(:constant_path), OptionalNodeField.new(:body), LocationField.new(:end_keyword_loc), ConstantField.new(:name)]
      when :multi_target_node
        [NodeListField.new(:lefts), OptionalNodeField.new(:rest), NodeListField.new(:rights), OptionalLocationField.new(:lparen_loc), OptionalLocationField.new(:rparen_loc)]
      when :multi_write_node
        [NodeListField.new(:lefts), OptionalNodeField.new(:rest), NodeListField.new(:rights), OptionalLocationField.new(:lparen_loc), OptionalLocationField.new(:rparen_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :next_node
        [OptionalNodeField.new(:arguments), LocationField.new(:keyword_loc)]
      when :nil_node
        []
      when :no_keywords_parameter_node
        [LocationField.new(:operator_loc), LocationField.new(:keyword_loc)]
      when :numbered_parameters_node
        [Integer.new(:maximum)]
      when :numbered_reference_read_node
        [Integer.new(:number)]
      when :optional_keyword_parameter_node
        [FlagsField.new(:flags, [:repeated_parameter?]), ConstantField.new(:name), LocationField.new(:name_loc), NodeField.new(:value)]
      when :optional_parameter_node
        [FlagsField.new(:flags, [:repeated_parameter?]), ConstantField.new(:name), LocationField.new(:name_loc), LocationField.new(:operator_loc), NodeField.new(:value)]
      when :or_node
        [NodeField.new(:left), NodeField.new(:right), LocationField.new(:operator_loc)]
      when :parameters_node
        [NodeListField.new(:requireds), NodeListField.new(:optionals), OptionalNodeField.new(:rest), NodeListField.new(:posts), NodeListField.new(:keywords), OptionalNodeField.new(:keyword_rest), OptionalNodeField.new(:block)]
      when :parentheses_node
        [OptionalNodeField.new(:body), LocationField.new(:opening_loc), LocationField.new(:closing_loc)]
      when :pinned_expression_node
        [NodeField.new(:expression), LocationField.new(:operator_loc), LocationField.new(:lparen_loc), LocationField.new(:rparen_loc)]
      when :pinned_variable_node
        [NodeField.new(:variable), LocationField.new(:operator_loc)]
      when :post_execution_node
        [OptionalNodeField.new(:statements), LocationField.new(:keyword_loc), LocationField.new(:opening_loc), LocationField.new(:closing_loc)]
      when :pre_execution_node
        [OptionalNodeField.new(:statements), LocationField.new(:keyword_loc), LocationField.new(:opening_loc), LocationField.new(:closing_loc)]
      when :program_node
        [ConstantListField.new(:locals), NodeField.new(:statements)]
      when :range_node
        [FlagsField.new(:flags, [:exclude_end?]), OptionalNodeField.new(:left), OptionalNodeField.new(:right), LocationField.new(:operator_loc)]
      when :rational_node
        [NodeField.new(:numeric)]
      when :redo_node
        []
      when :regular_expression_node
        [FlagsField.new(:flags, [:ignore_case?, :extended?, :multi_line?, :once?, :euc_jp?, :ascii_8bit?, :windows_31j?, :utf_8?, :forced_utf8_encoding?, :forced_binary_encoding?, :forced_us_ascii_encoding?]), LocationField.new(:opening_loc), LocationField.new(:content_loc), LocationField.new(:closing_loc), StringField.new(:unescaped)]
      when :required_keyword_parameter_node
        [FlagsField.new(:flags, [:repeated_parameter?]), ConstantField.new(:name), LocationField.new(:name_loc)]
      when :required_parameter_node
        [FlagsField.new(:flags, [:repeated_parameter?]), ConstantField.new(:name)]
      when :rescue_modifier_node
        [NodeField.new(:expression), LocationField.new(:keyword_loc), NodeField.new(:rescue_expression)]
      when :rescue_node
        [LocationField.new(:keyword_loc), NodeListField.new(:exceptions), OptionalLocationField.new(:operator_loc), OptionalNodeField.new(:reference), OptionalNodeField.new(:statements), OptionalNodeField.new(:consequent)]
      when :rest_parameter_node
        [FlagsField.new(:flags, [:repeated_parameter?]), OptionalConstantField.new(:name), OptionalLocationField.new(:name_loc), LocationField.new(:operator_loc)]
      when :retry_node
        []
      when :return_node
        [LocationField.new(:keyword_loc), OptionalNodeField.new(:arguments)]
      when :self_node
        []
      when :shareable_constant_node
        [FlagsField.new(:flags, [:literal?, :experimental_everything?, :experimental_copy?]), NodeField.new(:write)]
      when :singleton_class_node
        [ConstantListField.new(:locals), LocationField.new(:class_keyword_loc), LocationField.new(:operator_loc), NodeField.new(:expression), OptionalNodeField.new(:body), LocationField.new(:end_keyword_loc)]
      when :source_encoding_node
        []
      when :source_file_node
        [FlagsField.new(:flags, [:forced_utf8_encoding?, :forced_binary_encoding?, :frozen?, :mutable?]), StringField.new(:filepath)]
      when :source_line_node
        []
      when :splat_node
        [LocationField.new(:operator_loc), OptionalNodeField.new(:expression)]
      when :statements_node
        [NodeListField.new(:body)]
      when :string_node
        [FlagsField.new(:flags, [:forced_utf8_encoding?, :forced_binary_encoding?, :frozen?, :mutable?]), OptionalLocationField.new(:opening_loc), LocationField.new(:content_loc), OptionalLocationField.new(:closing_loc), StringField.new(:unescaped)]
      when :super_node
        [LocationField.new(:keyword_loc), OptionalLocationField.new(:lparen_loc), OptionalNodeField.new(:arguments), OptionalLocationField.new(:rparen_loc), OptionalNodeField.new(:block)]
      when :symbol_node
        [FlagsField.new(:flags, [:forced_utf8_encoding?, :forced_binary_encoding?, :forced_us_ascii_encoding?]), OptionalLocationField.new(:opening_loc), OptionalLocationField.new(:value_loc), OptionalLocationField.new(:closing_loc), StringField.new(:unescaped)]
      when :true_node
        []
      when :undef_node
        [NodeListField.new(:names), LocationField.new(:keyword_loc)]
      when :unless_node
        [LocationField.new(:keyword_loc), NodeField.new(:predicate), OptionalLocationField.new(:then_keyword_loc), OptionalNodeField.new(:statements), OptionalNodeField.new(:consequent), OptionalLocationField.new(:end_keyword_loc)]
      when :until_node
        [FlagsField.new(:flags, [:begin_modifier?]), LocationField.new(:keyword_loc), OptionalLocationField.new(:closing_loc), NodeField.new(:predicate), OptionalNodeField.new(:statements)]
      when :when_node
        [LocationField.new(:keyword_loc), NodeListField.new(:conditions), OptionalLocationField.new(:then_keyword_loc), OptionalNodeField.new(:statements)]
      when :while_node
        [FlagsField.new(:flags, [:begin_modifier?]), LocationField.new(:keyword_loc), OptionalLocationField.new(:closing_loc), NodeField.new(:predicate), OptionalNodeField.new(:statements)]
      when :x_string_node
        [FlagsField.new(:flags, [:forced_utf8_encoding?, :forced_binary_encoding?]), LocationField.new(:opening_loc), LocationField.new(:content_loc), LocationField.new(:closing_loc), StringField.new(:unescaped)]
      when :yield_node
        [LocationField.new(:keyword_loc), OptionalLocationField.new(:lparen_loc), OptionalNodeField.new(:arguments), OptionalLocationField.new(:rparen_loc)]
      else
        raise "Unknown node type: #{node.type.inspect}"
      end
    end
  end
end