#!/usr/bin/ruby -w

class Elem

  attr_accessor :content, :tag, :tag_type, :opt
  
  def initialize tag, *argv
    @tag = tag

    @content = argv[0]
    if @content == nil or @content == ""
      @content = []
    end
    if @content.class == String
      @content = [@content]
    end

    @tag_type = argv[1]
    if @tag_type != "simple"
      @tag_type = "double"
    end

    @opt = argv[2]
    if @opt == nil
      @opt = {}
    end
  end

  def add_content *elem
    elem.each do |tmp|
      if tmp.class == Array
        @content.concat(tmp)
      else
        @content.push(tmp)
      end
    end
  end

  def to_s
    if @opt != {}
      code = " "
      @opt.each do |key, val|
        code += "#{key}='#{val}' "
      end
    end

    if @content.class == Elem
      return "<#{@tag}#{code}>#{@content.to_s}</#{@tag}>"
    elsif @content.class == Array
      if @tag_type == "simple"
        return "<#{@tag}#{code}/>"
      end
      buffer = ""
      @content.each do |tmp|
        buffer += "\n" + tmp.to_s
      end
      return "<#{@tag}#{code}>#{buffer}\n</#{@tag}>"
    else
      return "<#{@tag}#{code}>#{@content.text}</#{@tag}>"
    end
  end
end

class Text
  
  attr_accessor :text
  
  def initialize text
    @text = text
    if text.class != String
      @text = text.to_s
    end
  end
end

class Supervisor < Elem
  def initialize content, opt={}
    @tag = self.class.to_s
    @content = content
    @tag_type = table
    @opt = opt
    super(@tag, @content, @tag_type, @opt)
  end
  
  def table
    if ["Meta", "Img", "Br", "Hr"].include? @tag
      return "simple"
    else
      return "double"
    end
  end
end

class Html < Supervisor; end
class Head < Supervisor; end
class Body < Supervisor; end
class Title < Supervisor; end
class Meta < Supervisor; end
class Img < Supervisor; end
class Table < Supervisor; end
class Th < Supervisor; end
class Tr < Supervisor; end
class Td < Supervisor; end
class Ul < Supervisor; end
class Ol < Supervisor; end
class Li < Supervisor; end
class H1 < Supervisor; end
class H2 < Supervisor; end
class P < Supervisor; end
class Div < Supervisor; end
class Span < Supervisor; end
class Hr < Supervisor; end
class Br < Supervisor; end

if $PROGRAM_NAME == __FILE__
   puts Html.new([Head.new([Title.new("Hello ground!")]), Body.new([H1.new("Oh no, not again!"), Img.new([], {'src':'http://i.imgur.com/pfp3T.jpg'}) ]) ])
end
