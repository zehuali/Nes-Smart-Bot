require "image";

labelfile = 'labels.lua'
train_set_file_name = "train_set.t7"
size = 38

lines = {}
for line in io.lines(labelfile) do 
    lines[#lines + 1] = tonumber(line)
end

print(lines)


imagesAll = torch.Tensor(size + 1,3,224,256)
local labelsAll = torch.Tensor(size + 1)

print(size)
print(type(imagesAll))

for f=0,size do
    print(f)
    imagesAll[f+1] = image.load('images/mario-'..f..'.png') 
    labelsAll[f+1] = 2 -- 2 = background
end

-- print(imagesAll)

-- shuffle dataset: get shuffled indices in this variable:
local labelsShuffle = torch.randperm((#labelsAll)[1])

local portionTrain = 1 -- 80% is train data, rest is test data
local trsize = torch.floor(labelsShuffle:size(1)*portionTrain)
local tesize = labelsShuffle:size(1) - trsize

-- create train set:
trainData = {
   data = torch.Tensor(trsize, 1, 224, 256),
   labels = torch.Tensor(trsize),
   size = function() return trsize end
}
--create test set:
testData = {
      data = torch.Tensor(tesize, 1, 224, 256),
      labels = torch.Tensor(tesize),
      size = function() return tesize end
   }

for i=1,trsize do
   trainData.data[i] = imagesAll[labelsShuffle[i]][1]:clone()
   trainData.labels[i] = labelsAll[labelsShuffle[i]]
end
for i=trsize+1,tesize+trsize do
   testData.data[i-trsize] = imagesAll[labelsShuffle[i]][1]:clone()
   testData.labels[i-trsize] = labelsAll[labelsShuffle[i]]
end

print(trainData)
torch.save(train_set_file_name, trainData)