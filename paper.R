

#install.packages("openxlsx", repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")

# 首先确保已经安装了 readxl 包，如果没有安装，使用以下命令安装
# install.packages("readxl")

library(readxl)

# 读取 Excel 文件
data <- read_excel("paper_data/基线数据.xlsx", sheet = "基线生化")

# 假设要读取的列为 "column_name"
column_data <- data$AST

# 计算平均值
average <- mean(column_data, na.rm = TRUE)

# 输出平均值
cat("平均值", average)
