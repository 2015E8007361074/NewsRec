#功能：提取数据集
#Author:wenyan yu
#Date:20151229
timeStart = Time.now

input = File.open("D:/ruby/DataFolder/NewsRecData/user_click_data.txt")
output = File.open("D:/ruby/DataFolder/NewsRecData/data_1000.txt","w")

max_user_count = 1000
user_count = 0

u_temp_id = 0 #标记前一条记录的用户id

outString = ""#输出字符串
 
input.each_line do |line| 
  
  sline = line.split(/\t/)  
  if sline[0] != u_temp_id #如果本次记录的用户id号去前一次记录不同，则为新用户，用户计数加1
    user_count += 1
    u_temp_id = sline[0]
    break if user_count > max_user_count
  end
  outString = "#{outString}#{sline[0]},#{sline[1]},#{sline[3]}\n"
end

#puts outString

output.write(outString)#写文件

output.close()
input.close()
timeEnd = Time.now

puts "Time consuming:#{timeEnd-timeStart}"