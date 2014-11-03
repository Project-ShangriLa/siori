require 'rubygems'
require 'gruff'

OUTPUT_FOLDER = "graph"

#array_data [20000, 23000, 7000, 800, 15000, 2000, 3000, 2008, 5005, 6002, 3300,1005]
#{0 => '08/04', 1 => '08/05', 2 => '08/06', 3 => '08/07',
#   4 => '08/08', 5 => '08/09', 6 => '08/10', 7 => '08/11', 8 => '08/12',
#   9 => '09/01', 10 => '09/02', 11 => '09/03'}
def draw_grahics (array_data, label_hash, filename, time)
#.new(横幅)で4対3の画像を生成。
#.new('横幅x縦幅')で任意サイズの画像を生成する。
  g = Gruff::SideStackedBar.new(1000)

#タイトル。linuxの場合UTF8でないと化けるという情報あり。
  g.title = "Amazon DVDカテゴリランキング [" + 
  time.strftime("%Y年%m月%d日 %H時%M分%S秒") + "]"
  
 #タイトルのフォントサイズ
  g.title_font_size = 20
  
  #TTFのフォントをフルパスで指定。日本語フォントを指定する。
  g.font = "/Library/Fonts/Osaka.ttf"
  
  #目盛りの刻みを指定する。指定しないと自動計算して
#切りの悪い数値になってしまうので注意。
  g.y_axis_increment = 100
  #g.theme_rails_keynote()
  #グラフの最大値。値が指定した最大値を超えた場合、
#目盛りを適当に増やしてくれる。
#最大値のデフォルト程度のイメージ。
  g.maximum_value = 10000
  
  #g.additional_line_values = 1000
  
#グラフの最小値。指定しないと自動計算して適当な数値から
#始まってしまうので基本的に0を指定する。
  g.minimum_value = 0
  
  #data(name, [値1,値2,値3,...],'RPG値')でデータを代入する。
  g.data 'Rank', array_data

  g.left_margin = 100
  
  #凡例を表示しない
  g.hide_legend = true
  
  #タイトルを表示しない
  g.hide_title = false
  
  #補助線を表示しない(あまり使わないはず）
  g.hide_line_markers = false

  #列(水平側）のラベルを指定する。0から始まることに注意。
  g.labels = label_hash
   
  #ラベル、目盛り等補助情報のフォントサイズ。デフォルト20pt
  g.marker_font_size = 12
  
  #値をソートしない(デフォルトはtrue）
  g.sort = false

  filename = OUTPUT_FOLDER + "/" + filename + time.strftime("%Y-%m-%d %H-%M-%S") +".png"
  
  #write(ファイルパス)で画像をファイル出力する。
  g.write(filename)
  
  return filename
end