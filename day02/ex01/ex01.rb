#!/usr/bin/ruby -w

class Html
  attr_reader :name

  def initialize(name)
    @page_name = name
    head
  end

  def head
    if File.exist? ("#{@page_name}.html")
      raise RuntimeError ,"RuntimeError: #{@page_name}.html already exist!"
    else
      File.new("#{@page_name}.html", "w+").syswrite <<~HEAD
      <!DOCTYPE html>
      <html>
      <head>
      <title>#{@page_name}</title>
      </head>
      <body>
      HEAD
    end
  end

  def dump(str)
    fd = File.new("#{@page_name}.html", "a+")
    buffer = fd.sysread(fd.stat.size)
    unless buffer.include? "<body>"
      raise RuntimeError, "RuntimeError: There is no body tag in #{@page_name}.html"
    end
    if buffer.include? "</body>"
      raise RuntimeError, "RuntimeError: Body has already been closed in #{@page_name}.html"
    end
    fd.syswrite "\t<p>#{str}</p>\n"
    fd.close
  end

  def finish
    fd = File.new("#{@page_name}.html", "a+")
    if fd.include? "</body>"
      raise RuntimeError, "RuntimeError: #{@page_name}.html has already been closed."
    end
    q = fd.syswrite "</body>"
    fd.close
    return q
  end
end

if $PROGRAM_NAME == __FILE__
a = Html.new("abc")
b = Html.new("def")
a = Html.new("abc")
a.dump("aaa")
b.dump("aaa")
a.finish
b.finish
end
