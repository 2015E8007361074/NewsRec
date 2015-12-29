require 'rubygems'
require 'knn'

randseed = Random.new(1)
data = Array.new(10000){Array.new(4){randseed.rand}}
#p data
knn = KNN.new(data)

p knn.nearest_neighbours([1,2,3,4],4) #([data],k's)

#[data index,distance to the input,[data points]]
p data[6526]

#距离的计算方法
#euclidean_distance
#cosine_similarity
#jaccard_index
#jaccard_distance
#binary_jaccard_index
#binary_jaccard_distance
#tanimoto_coefficient
#使用方法
#KNN.new(@data, :distance_measure => :jaccard_index)
#KNN.new(@data, :distance_measure => :cosine_similarity)
#KNN.new(@data, :distance_measure => :tanimoto_coefficient)
