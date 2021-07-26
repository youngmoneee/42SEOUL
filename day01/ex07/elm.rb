#!/usr/bin/ruby -w

class MAKEFILE

  #초기화

  def initialize (path)
    fd = File.new(path, "r")
    if fd
      $periodic = fd.sysread(fd.stat.size).split("\n")
      $periodic.length.times do |i|
        $periodic[i] = $periodic[i].split(/,|\s|=|:/,18).map(&:strip).delete_if{|x| x == ""}
      end
    else
      return nil;
    end
  end

  #파일 생성
  
  def make_file (obj)
    $html = File.new(obj, "w+")
    if $html
      self.make_header
      self.make_body
      $html.syswrite "\t\t\t\t\n</tr>\n\t\t\t</table>\n\t\t</div>\n\t</body>\n</html>"
    end
  end

  #헤더 생성

  def make_header
    $html.syswrite <<~HEADER
<!doctype html>
<html lang="en-US">
  <head>
    <meta charset="UTF-8" />
    <title>periodic table</title>
    <style>
  body{
    text-align : center;
    font-size : 14px;
  }
  table{
    table-layout : fixed;
  }
  .board{
    width : 100%;
    height : 80%;
    text-align : center;
    margin : 0 auto;
  }
  ul{
    text-align:left;
    float : left;
    margin : 0;
    padding : 0;
  }
  ul li{
    list-style : none;
    margin : 0;
    padding : 0;
  }
  tr, td{
    width : 5.5%;
    height : auto;
  }
</style>
</head>
    HEADER
  end

  #바디 생성

  def make_body
    $html.syswrite <<~INTRO
    \t<body>\n<div class="board">\n\t\t\t<table>\n\t\t\t\t<tr>
    INTRO
    a = 0
    $periodic.length.times do |i|
      ($periodic[i][2].to_i-a-1).times do
        self.make_blank
      end
      a = $periodic[i][2].to_i
      self.make_table(i)
      if $periodic[i][2].to_i == 17 && $periodic[i][4].to_i != 118
        $html.syswrite "</tr>\n<tr>\n"
        a = 0
      end
    end
  end

  #테이블 생성

  def make_table(i)
    name = $periodic[i][0]
    pos = $periodic[i][2]
    num = $periodic[i][4]
    small = $periodic[i][6]
    volume = $periodic[i][8]
    electron = $periodic[i][10]
    $html.syswrite <<~BODY
        <td style = "border : 1px solid black; padding:10px;">
          <h4>#{name}</h4>
          <ul>
            <li>No #{num}</li>
            <li>#{small}</li>
            <li>#{volume}</li>
            <li>#{electron} electron</li>
          </ul>
        </td>
    BODY
  end

  #공백 생성

  def make_blank
    $html.syswrite <<~BLANK
      <td style = "empty-cells : hide;"></td>
    BLANK
  end

end

html = MAKEFILE.new("periodic_table.txt")
html.make_file("periodic_table.html")
