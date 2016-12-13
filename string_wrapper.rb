class StringWrapper < Parser::Rewriter
  def on_dstr(node)
    insert_before(node.loc.begin, "_(")
    insert_after(node.loc.end, ")")
  end

  def on_str(node)
    puts node.loc
    if node.loc.respond_to?(:heredoc_body)
      insert_before(node.loc.expression, "_(")
      insert_after(node.loc.expression, ")")
    elsif node.loc.respond_to?(:begin) # avoid constants, like __FILE__, which should not be marked
      # do not mark empty strings, which are just two quotes
      return if node.loc.expression.length == 2

      insert_before(node.loc.begin, "_(")
      insert_after(node.loc.end, ")")
    end
  end

  def on_send(node)
    method_name = node.loc.selector.source
    if ((method_name == 'require') ||
      (method_name == "_") ||
      (/\[.*\]/.match method_name))
      return
    end
    super
  end

  def on_regexp(node)
    return
  end
end

