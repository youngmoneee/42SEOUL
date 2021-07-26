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

if $PROGRAM_NAME == __FILE__
  body = Elem.new('body')
  head = Elem.new('head')
  h1 = Elem.new('h1',Text.new('"Oh no, not again!"'))
  title = Elem.new('title', Text.new('"Hello ground!"'))
  img = Elem.new('img', '', 'simple',{'src':'http://i.imgur.com/pfp3T.jpg'})
  html = Elem.new('html')
  head.add_content(title)
  body.add_content(h1, img)
  html.add_content(head, body)
  puts html
end
