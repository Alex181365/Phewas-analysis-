library(ieugwasr)
library(mrasst)
riskloc <- read.csv('risk_loc.csv', header=T)
IV <- TwoSampleMR::format_data(riskloc,type='exposure',snp_col = "Rsid",
                               beta_col = "Beta",
                               se_col = "SE",
                               eaf_col = "Eaf",
                               effect_allele_col = "Effect.allele",
                               other_allele_col = "Other.allele",
                               pval_col = "P.value")

#使用twosamplemr包进行clump
IV_clump <- TwoSampleMR::clump_data(IV)
#使用mrasst包进行clump
IV_clump <- mrasst::mrclump(IV)


#测试
IVinfo <- IV_clump[1:5,]

#获取SNP数据
Traitinfo <- getAtlas(IVinfo)
#寻找关联
enrichment <- getEnrichment(IVinfo,Traitinfo)
#MR-Phewas
mr_result <- getMR_Atlas(IVinfo,Traitinfo)
#异质性检测
mr_heter <- getMR_Atlas_heterogeneity(IVinfo,Traitinfo)
#多效性检测
mr_pleio <- getMR_Atlas_pleiotropy(IVinfo,Traitinfo)
