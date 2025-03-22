# Phewas analysis

# 示例1是个体phewas数据的分析，示例2是群体phewas数据的分析。

单核苷酸多态性（SNP）是一种突变，其中特定位点的单个核苷酸碱基已被不同的核苷酸取代，而出现在每个基因座上的不同可能的核苷酸成为等位基因，在群体中频率大于1%

检测SNP的方法：nex-generation sequencin, microarray等

一般来说，在人类基因组中大约每千个碱基中有一个SNP

SNP 可以通过影响基因间区域，基因非编码区域和基因编码区域来影响表现。 在基因编码区域中，snp可能带来非同义突变（错义突变）和同义突变（本身不会改变蛋白质序列，但其会影响mRNA 二级结构、蛋白折叠以及细胞定位）

发生在基因非编码区或基因间区可能会影响转录因子与 DNA 结合、影响非编码 RNA 序列
、影响基因的剪接、 mRNA 的降解等。
内含子中 SNP 主要依靠影响剪切位点活性来影响基因功能。剪切位点的失活可能会影响
翻译，影响蛋白质序列。
基因调控区域包启动子区域、增强子区域等等，这些区域含有很多基因表达调控元件，如
：转录因子结合位点。这些序列元件和调控因子（如转录因子）结合需要特定的序列组成
，这些位点的 SNP 发生变化，就会导致与调控因子的结合能力发生改变，从而影响正常
的基因表达。

在研究基因型与表型的关系或者表型与表型的关系时，我们通常使用的
是线性模型：
• 对于连续的因变量————线性回归
• 对于分类的因变量————逻辑回归
一般，主等位基因纯合编码为 0 ，杂合为 1 ，次等位基因纯合编码为 2

Phewas, 全表型相关联研究（反向GWAS），是考察全表型组范围所有表型与一SNP或者某一表型之间的关联方法（一个或多个SNP对应许多个表型）

使用多个 SNP 来研究某表型与全表型之间的关系（基于多基因评分）
多基因评分（ PGS ）是整个基因组表型相关等位基因的线性组合，通
常由 GWAS 效应大小加权。复杂的性状与许多遗传变异有关，每一个
变异都只占变异的一小部分。 PGSs 是一种跨基因组聚合这些信息的解
决方案。（工具：PHESANT, PheWAS）

SNP 信息相关数据库：
SNPedia

SNP 信息相关数据库：
1. ieu open gwas project(https://gwas.mrcieu.ac.uk/phewas/)
2. Finngen （ www.finngen.fi/en ）
3. the HaemGen consortium （血液相关）
4. Coronary Artery Disease Genome wide Replication and Meta-analysis plus the
Coronary Artery Disease Genetics (CARDIoGRAMplusC4D) （冠状动脉疾病）
5. the Global Lipids Genetics Consortium (GLGC) （脂质相关）
6. the Nuclear Magnetic Resonance (NMR)-GWAS summary statistics （存储了通过核磁共振技术收集的生物分子数据，例如代谢产物的浓度或特征）
7. the Genetic Investigation of ANthropometric Traits (GIANT) consortium （身体形态特
征）
8. the Meta-Analysis of Glucose and Insulin related traits Consortium (MAGIC) （血糖调节和胰岛素代谢）


分析需要的数据：
1. 寻找snp（通过文章找，注意人群背景，Minor allele frequency > 1%, LD clump）

LD clump: SNP（单核苷酸多态性）的连锁不平衡（Linkage Disequilibrium，简称LD）
是遗传学中的一个概念，指的是两个或多个不同的SNP在基因组中以非随
机方式共同出现。具体来说，当两个或多个SNP在一群个体中的基因型之
间存在非随机的相关性时，就可以说它们处于连锁不平衡状态。

基于LD的R2，以及GWAS所得到的p值，来筛选出这个LD区域中的代表SNP（重要性最高）。
LD Clump：首先会依据从GWAS得到的p值对SNP的重要性进行排序，然后选取排序后的第一个SNP， 计算这个SNP与窗口区间（clump_kb）里其他SNP的R2， 当检测到高的相关性时，就会从这一对SNP中去除重要性低的那个， 这个过程中我们选的第一个SNP一定会得到保留。 完成后下一步就是选取p值排序后的下一个SNP，重复这个过程。
一般SNP个数越少，存在的混杂和多效性也就越少，但相应的统计效力不足；
而SNP数目的增多虽然能提高统计效力，但也会带来更多的偏倚。

LD_clump参数一般为10,000kb 和 r2 < 0.001(工具可以是twosampleMR的clump_data和ieugwasr 包中的Id_clump)


2. 寻找表型：
biobank: https://www.ukbiobank.ac.uk/

Gene Atlas: associations for 118 non-binary and 660 binary traits of 452,264 UK Biobank participants of European ancestry.

ieu open gwas project- GWAS summary data: 3948种表型 来自UKbiobank


Pan-UK Biobank: A multi-ancestry analysis of 7,228 phenotypes, across 6 continental ancestry groups, for a total of
16,131 genome-wide association studies 2020


3. 筛选表型的原则： 

排除病例数不少于200例的Phecode。病例数少于100例的二元表型，以及样本量少于10,000的连续和有序分类表型也被排除。没有主要ICD编码或有外部原因（编码为Z00–Z99）的ICD编码二元表型也被排除。

为了考虑多重检验的问题，我们在主要分析结果中采用了Bonferroni校正阈值p < 2.3 × 10⁻⁵（0.05/2242）。鉴于各种表型之间可能存在相关性，Bonferroni校正阈值可能被认为过于保守，因此我们还在二次分析中使用了经过调整的假发现率（FDR）阈值0.05（p < 0.00495），以识别与TS多基因风险评分（PRS）相关的其他表型。


4. stratify and replicate analysis:
用上述的其他数据库重新分析一遍

5. 双边z检验
双边Z检验是用于比较两个样本或两个群体之间平均值是否存在显著差异的统计方法。它的目的是确定两个群体的均值是否在统计上有显著不同，而不仅仅是判断哪个群体的均值更大或更小。双边的Z检验的核心思想是将样本均值与另一个样本均值进行比较，看是否有显著差异。它之所以称为"双边"，是因为它关心的是样本均值相对于总体
均值的两侧，即考虑在两个方向上的偏离。

6. SNP对照组
publication: SNPsnap: a web-based tool for identification and annotation of matched SNPs

7. 协变量：
including sex,
body mass index (BMI),
age,assessment centre,
genotyping batch,
the principal components.

TeraPCA: a fast and scalable software package to study genetic variation
in tera-scale genotype

# 分析流程：
个体数据（phenotype, genotype((SNP or PRS)), covariates）- 寻找关联（Phewas, PHESANT）- MR
汇总数据-MR-Phewas/(寻找关联比较enrichment-MR)


# Fisher's exact test: 

费舍尔精确检验（Fisher's exact test）是一种用于计算两个类别变量之间
的相关性的非参数检验方法。它的目的是确定两个类别变量之间的联合概率
分布，从而检验它们之间是否存在显著的相关性。
费舍尔精确检验适用于样本量较小的情况下，特别是在存在稀疏数据的情况
下。与卡方检验（chi-square test）相比，费舍尔精确检验更加准确。
