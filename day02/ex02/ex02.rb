#!/usr/bin/ruby -w

class Html
  attr_reader :name

  def initialize(name)
    @page_name = name
    head
  end

  def head
    begin
      if File.exist? ("#{@page_name}.html")
        raise Dup_file.new(@page_name)
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
    rescue Dup_file => e
      e.show_state
      @page_name = e.correct
    end
  end

  def dump(str)
    fd = File.new("#{@page_name}.html", "a+")
    buffer = fd.sysread(fd.stat.size)
    unless buffer.include? "<body>"
      raise RuntimeError, "RuntimeError: There is no body tag in #{@page_name}.html"
    end
    begin
    if buffer.include? "</body>"
      raise Body_closed.new(@page_name, str)
    end
    fd.syswrite "\t<p>#{str}</p>\n"
    fd.close
    rescue Body_closed => e
      e.show_state
      e.correct
    ensure
      fd.close
    end
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

class Dup_file < StandardError
  
  def initialize page_name
    @page_name = page_name
  end
  def show_state
    puts "A file named #{@page_name}.html was already there: #{Dir.pwd}/#{@page_name}.html"
  end

  def correct
    @page_name = @page_name + ".new"
    if File.exist? ("#{@page_name}.html")
      correct
    else
      File.new("#{@page_name}.html", "w+").syswrite <<~HEAD
      <!DOCTYPE html>
      <html>
      <head>
      <title>#{@page_name}</title>
      </head>
      <body>
      HEAD
      explain
      return @page_name
    end
  end

  def explain
    puts "Appended .new in order to create requested file: #{Dir.pwd}/#{@page_name}.html"
  end
end

class Body_closed < StandardError

  def initialize page_name, str
    @page_name = page_name
    @str = str
  end

  def show_state
    puts "In #{@page_name}.html body was closed :"
  end

  def correct
    File.write("#{@page_name}.html", File.read("#{@page_name}.html").gsub(/<\/body>/, "\t<p>#{@str}</p>\n</body>"))
    explain
  end

  def explain
    IO.foreach("#{@page_name}.html").with_index(1) do |line, ln|
      if line.include? "</body>"
        puts "  > ln :#{ln} #{line.chomp} : text has been inserted and tag moved at the end of it."
      end
    end
  end

end

if $PROGRAM_NAME == __FILE__
a = Html.new("abc")
a = Html.new("abc")
a.finish
a.dump("aaa")
a.dump("aaa2")
a.finish
a.dump("abc3")
a.finish
end
