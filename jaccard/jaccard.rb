#Author:Wenyan yu
#Date:20151230

class User < Struct.new(:news_title)
  
  def words
    @words ||= self.news_title.gsub(/\s/,"").split(/\//).uniq.sort
  end
end

class NewsRecommender
  def initialize news,newss
    @news, @newss = news, newss
  end
  
  def recommendations
    #计算每个元素的jaccard_index值并排序
    @newss.map! do |this_news|
      #运行中定义jaccard_index值并排序
      this_news.define_singleton_method(:jaccard_index) do
        @jaccard_index
      end
      
      #还有赋值方法
      this_news.define_singleton_method("jaccard_index=") do |index|
        @jaccard_index = index || 0.0
      end
      
      #计算样本的交集
      intersection = (@news.words & this_news.words).size
      #计算样本的并集
      union = (@news.words | this_news.words).size
      
      #将除法的运算结果赋值，如无法计算测捕捉异常并赋值为0
    this_news.jaccard_index = (intersection.to_f / union.to_f) rescue 0.0
    
    this_news
    #排序  
    end.sort_by {|news| 1- news.jaccard_index}    
  end
end

#推荐过程

#读取新闻列表，并定义新闻数组
NewsArray = DATA.read.split("\n").map{ |l| User.new(l)}

#定义当前用户浏览新闻爱好
current_news = User.new("消失 / 前 / 的 / 马航 / 370")  

#将已读取的新闻列表与该用户浏览新闻爱好进行Jaccard相似度计算，计算推荐概率，并排序
#选出推荐概率最大的几个新闻推荐给用户

newss = NewsRecommender.new(current_news, NewsArray).recommendations()

newss.each do |news|
  puts "#{news.news_title}(#{'%.2f' % news.jaccard_index})"
end


=begin
str1 = "马航 / 代表 / 与 / 乘客 / 家属 / 见面"
str2 = "马航 / 召开 / 新闻 / 发布会 / 通报 / 失联 / 航班 / 最新 / 情况"

title = "Ruby programming language"  
p word1 ||= title.gsub(/[a-zA-Z]{3,}/).map(&:downcase).uniq.sort
p s1 ||= str1.gsub(/\s/,"").split(/\//).uniq.sort
p s2 ||= str2.gsub(/\s/,"").split(/\//).uniq.sort

p union = (s1 | s2).size
=end
__END__
消失 / 前 / 的 / 马航 / 370
马航 / 代表 / 与 / 乘客 / 家属 / 见面
马航 / 召开 / 新闻 / 发布会 / 通报 / 失联 / 航班 / 最新 / 情况
马航 / 失联 / 航班 / 搜救 / 画面
广西 / 警方 / 摧毁 / 特大 / 贩毒 / 网络
NASA / 发布 / 疑似 / 马航 / 航班 / 失事 / 地点 / 高清 / 地图

