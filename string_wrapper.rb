class StringWrapper < Parser::Rewriter
  def on_dstr(node)
    insert_before(node.loc.begin, "_(")
    insert_after(node.loc.end, ")")
  end

  def on_str(node)
    if node.loc.respond_to?(:heredoc_body)
      insert_before(node.loc.expression, "_(")
      insert_after(node.loc.expression, ")")
    elsif node.loc.respond_to?(:begin)
      # avoid constants, like __FILE__, which do not have begin/end nodes,
      # and should not be marked
      str = node.children[0]
      return if str == ""         # ignore empty strings
      return if str !~ /[A-Za-z]/ # ignore non-text strings
      return if str =~ /^\.*\//   # ignore many file paths

      insert_before(node.loc.begin, "_(")
      insert_after(node.loc.end, ")")
    end
  end

  def on_send(node)
    method_name = node.loc.selector.source
    if ((method_name == 'require') || # ignore requires
      (method_name == "_") ||         # ignore marked strings
      (/\[.*\]/.match method_name))   # ignore hash keys
      return
    end
    super
  end

  def on_regexp(node)
    return
  end
end

