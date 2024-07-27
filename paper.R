

#install.packages("openxlsx", repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")

# 首先确保已经安装了 readxl 包，如果没有安装，使用以下命令安装
#install.packages("dplyr", "ggplot2")

source("~/.Rprofile")

library(readxl)
library(dplyr)
library(ggplot2)

# 读取 Excel 文件
data <- read_excel("paper_data/基线数据.xlsx", sheet = "基线生化")

# 提取 AST 列的数据
ast_data <- data$AST

# 计算均值和标准差
mean_ast <- mean(ast_data, na.rm = TRUE)
std_ast <- sd(ast_data, na.rm = TRUE)

# 打印均值和标准差
print(paste("AST 的均值为:", mean_ast))
print(paste("AST 的标准差为:", std_ast))

# 绘制图形
ggplot(data, aes(x = AST)) + 
  geom_histogram(binwidth = 10, fill = "steelblue", color = "black") + 
  labs(title = "AST 分布", x = "AST 值", y = "频数")

ggsave("plots/myplot.png", width = 12, height = 12) 