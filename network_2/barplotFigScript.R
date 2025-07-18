# load packages
library(ggplot2)


# bar graph #

# load data
data = read.table(file.choose(), header = FALSE, stringsAsFactors = FALSE)

# add a ID column
data$ID = rep(1:100, each = 2)

# add an event variable
data$eventType = rep(c("Consistent", "Inconsistent"), each = 1, times = 100)
data$eventType = as.factor(data$eventType)

# add a looking time/choice variable
data$looking_time = data$V3

data = data[,-c(1:3)]


# compute descriptive statistics
mean_consistent = mean(data$looking_time[data$eventType=='Consistent'])
sd_consistent = sd(data$looking_time[data$eventType=='Consistent'])


mean_inconsistent = mean(data$looking_time[data$eventType=='Inconsistent'])
sd_inconsistent = sd(data$looking_time[data$eventType=='Inconsistent'])


# now plot data
condition_barplot = ggplot(data, aes(eventType, looking_time, fill=eventType)) # create the bar graph with test.trial.2 on the x-axis and measure on the y-axis
condition_barplot + stat_summary(fun = mean, geom = "bar", position = "dodge") + # add the bars, which represent the means and the place them side-by-side with 'dodge'
  stat_summary(fun.data=mean_cl_boot, geom = "errorbar", position = position_dodge(width=0.90), width = 0.2) + # add errors bars
  ylab("Looking Time") + # change the label of the y-axis
  scale_y_continuous(expand = c(0, 0)) +
  coord_cartesian(ylim=c(0, 5)) +
  scale_fill_manual(values = c("black", "azure3")) +
  labs(fill='Test Trial')  +
  theme(axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10), 
        legend.text=element_text(size=10),
        legend.title = element_text(size=10),
        axis.title=element_text(size=10),
        strip.text = element_text(
          size = 10), 
        axis.title.x = element_blank())
