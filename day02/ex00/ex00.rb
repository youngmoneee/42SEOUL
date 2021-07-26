#!/usr/bin/ruby -w

class Html
  attr_reader :name
  
  def initialize(name)
    @page_name = name
    if File.new("#{@page_name}.html", "w+") == nil
      return nil
    end
    self.make_header
  end
  
  def make_header
    fd = File.new("#{@page_name}.html", "a+")
    fd.syswrite <<~HEAD
      <!DOCTYPE html>
      <html>
      <head>
      <title>#{@page_name}</title>
      </head>
      <body>
    HEAD
    fd.close
  end

  def dump(str)
    fd = File.new("#{@page_name}.html", "a+")
    fd.syswrite "  <p>#{str}</p>\n"
    fd.close
  end

  def finish
    fd = File.new("#{@page_name}.html", "a+")
    q = fd.syswrite "</body>"
    fd.close
    return q
  end
end

if $PROGRAM_NAME == __FILE__
  a = Html.new("test")
  a.dump("a")
  a.dump("b")
  a.finish
end
