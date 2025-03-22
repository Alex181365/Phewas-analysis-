# 载入PheWAS和dplyr包
library(PheWAS)
library(dplyr)

# 从CSV文件中读取数据
id.vocab.code.count = read.csv('id.vocab.code.count.csv')
genotypes = read.csv('genotypes.csv')
id.sex = read.csv('id.sex.csv')

# 使用createPhenotypes函数处理数据，生成表型数据
phenotypes = createPhenotypes(id.vocab.code.count,
                              aggregate.fun=sum, id.sex=id.sex)

# 将phenotypes, genotypes和id.sex通过内部连接合并为一个数据框
data = inner_join(inner_join(phenotypes, genotypes), id.sex)

# 对合并的数据执行PheWAS分析
results = phewas_ext(data, phenotypes=names(phenotypes)[-1], genotypes=c("SNP1"),
                     covariates=c("sex"), cores=1)

# 绘制PheWAS的曼哈顿图
phewasManhattan(results,
                title="Manhattan Plot")

# 为结果添加Phecode信息
results_d = addPhecodeInfo(results)

# 显示p值最小的前10个结果
results_d[order(results_d$p)[1:10], ]

# 使用phewasDT函数展示结果
phewasDT(results)
