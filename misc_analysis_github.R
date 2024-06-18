
pacman::p_load(tidyverse, lme4, lmtest, emmeans, broom)                         

df <- read_excel("PeptideFreeProteinContent_BCA.xlsx")
whole = df[, 5]

df = df[1:3, 1:4]

df = reshape2::melt(df)

df$filter[grepl("F", df$variable)] <- "filtered"
df$filter[!grepl("F", df$variable)] <- "unfiltered"

df$variable <- as.character(df$variable) 

df$variable = ifelse(df$variable == "AMW20,F", "AMW20_F", df$variable) 
df$variable = ifelse(df$variable == "AMW50,F", "AMW50_F", df$variable) 

df$variable <- as.factor(df$variable) 
df$value <- as.numeric(df$value) 


fit= lm(log(value) ~ variable, data = df) 


tidy(fit)


plot(fit) 

em = emmeans(fit,  specs = ~ variable, scale = "response") 
am20 = c(1, 0, 0, 0)
amf20 = c(0, 1, 0, 0)
am50 = c(0, 0, 1, 0)
amf50 = c(0, 0, 0, 1) 

contr = contrast(em, method = list("AMW20 - AMW20 Filtered" = am20 - amf20, 
                                   "AMW50 - AMW50 Filtered" = am50 - amf50))

contr |> confint()

plot(em) + 
  xlab("Estimated Marginal Mean") + ylab("Method")

ggsave("emmeans.pdf") 

# contrast(em, method = list("AMW50 - AMW50 Filtered" = am50 - amf50))

plot(em) 

em <- as.data.frame(em) 

# ggplot(em, aes(x = variable, y = emmean )) +
#   geom_point() +
#   geom_errorbar(ymin = lower.CL, ymax = upper.CL) 
# 






