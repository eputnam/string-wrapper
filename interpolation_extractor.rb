require 'pry'
require 'pry-nav'

class InterpolationExtractor < Parser::Rewriter
  def on_send(node)
    receiver_node, method_name, *arg_nodes = *node
    if (method_name == :_) && (arg_nodes[0].type == :dstr)
      values = extract_interpolations(arg_nodes[0])
      if !values.empty?
        insert_after(node.loc.end, " % #{values}")
      end
    end
    super
  end

  def extract_interpolations(node)
    # Strings with interpolation are dstr nodes
    return if node.type != :dstr

    # A string representation of the hash argument to the string
    # format method
    interpolated_values_string = ""
    # Used to build placeholder names for complex expressions
    count = 0
    node.children.each do |child|
      # dstrs are split into "str" segments and other segments.
      # The "other" segments are the interpolated values.
      if child.type == :begin
        value = child.children[0]
        hash_key = "value"
        if value.type == :lvar
          # Use the variable's name as the format key
          hash_key = value.loc.name.source
        else
          # These are placeholders that will manually need to be given
          # a descriptive name
          hash_key << "#{count}"
          count += 1
        end
        if interpolated_values_string.empty?
          interpolated_values_string << "{ "
        end
        interpolated_values_string << "#{hash_key}: #{value.loc.expression.source}, "

        # Replace interpolation with format string
        replace(child.loc.expression, "%{#{hash_key}}")
      end
    end
    if !interpolated_values_string.empty?
      interpolated_values_string << "}"
    end
    return interpolated_values_string
  end
end

