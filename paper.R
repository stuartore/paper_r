

#install.packages("openxlsx", repos = "https=//mirrors.tuna.tsinghua.edu.cn/CRAN/")

# 首先确保已经安装了 readxl 包，如果没有安装，使用以下命令安装
#install.packages("dplyr", "ggplot2")

source("~/.Rprofile")

library(sysfonts)
library(showtextdb)
library(showtext)
showtext_auto()

library(readxl)
library(dplyr)
library(ggplot2)

library(gtsummary)


# 读取 Excel 文件
data <- read_excel("paper_data/基线数据.xlsx", sheet = "基线生化")

# 提取 AST 列的数据
ast_data <- data$AST

# 计算均值和标准差
mean_ast <- mean(ast_data, na.rm = TRUE)
std_ast <- sd(ast_data, na.rm = TRUE)

library(compareGroups)

#cat(names(data))

names_mapping <- c(
  "序号" = "Index", "是否诊断PA" = "if_pa", "是否诊断原高" = "if_ph",
  "床号" = "BedNum", "姓名" = "PatientName", 
  "年龄" = "Age", "住院号" = "HospNum", "身高" = "Height", "体重" = "Weight",
  "AHI指数" = "AHI_index", "备注（出院日期）" = "More Notes",
  "糖化血红蛋白" = "Hb1Ac", "白细胞" = "WBC", "中性粒细胞" = "N", "淋巴细胞" = "L",
    "血红蛋白" = "Hb", "血小板" = "Plt",  "总胆固醇" = "TG", "甘油三酯" = "Triglycerides", 
    "非HDL胆固醇" = "non-HDL-C",
    "性别（男1、女0）" = "Sex",
    "HDL-C" = "HDL",
    "LDL-C" = "LDL",
    "载脂蛋白-A" = "Apo-A",
    "肌酐（尿）" = "Cr-urine",
    "Sp02" = "SpO2", 
    "HDL-C" = "HDL_C", 
    "LDL-C" = "LDL_C", 
    "载脂蛋白-B" = "Apo-B",
    "载脂蛋白-E" = "Apo-E",
    "脂蛋白a" = "Lp(a)", "同型半胱氨酸" = "Homocysteine",  "尿素" = "urea",
     "肌酐" = "Cr", "尿酸" = "Uric acid", "钾" = "K", "钠" = "Na",  "氯" = "Cl", "总钙" = "Ca2+", "尿微量白蛋白" = "Urine microalbumin",
    "空腹血糖mmol/L" = "fasting blood sugar", 
    "24h尿K" = "24h urine K",
    "24h尿Na" = "24h urine Na", 
    "立位ARR", "Stand ARR",
    "卧位ARR" = "Recumbent ARR",
    "卧位肾素（5点）" = "Recumbent renin 5am", 
    "立位醛固酮（7点）" = "Orthostatic aldosterone 7am",
    "立位肾素（7点）" = "orthorenin 7am", 
    "卧位醛固酮（5点）" = "Recumbent aldosterone 5am", 
    "血浆皮质醇测定（早上8:00）" = "Cortisol 8am", 
    "血浆皮质醇测定（下午16:00）" = "Cortisol 16pm",
    "血浆皮质醇测定（晚上0:00）" = "Cortisol 0am",
    "促肾上腺皮质激素" = "corticotropin"
)

# 定义一个函数来处理名称修改
modify_names <- function(df, mapping) {
  new_names <- names(df)
  for (old_name in names(mapping)) {
    new_names[new_names == old_name] <- mapping[old_name]
  }
  names(df) <- new_names
  return(df)
}

data <- modify_names(data, names_mapping)

bio_data <- data[ , !(names(data) %in% c('Index', 'BedNum', 'PatientName', 'HospNum', 'SpO2', 'More Notes'))]

bio_data$AHI_group <- cut(bio_data$AHI_index, 
  breaks = c(-Inf, 15, Inf),
  labels = c("<15", ">=15"),
  include.lowest = TRUE
)
cat("\n", names(data))

print(descrTable( AHI_group ~ ., data = bio_data))


