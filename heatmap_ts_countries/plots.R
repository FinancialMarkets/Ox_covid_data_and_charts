library(ggplot2)
library(readr)
library(viridis)
library(scales)

african_data <- read_csv("../african_data.csv")
african_data$Date <- as.Date(as.character(african_data$Date), format = "%Y-%m-%d")

names(african_data)[4] <- "School Status"
african_data$y <- african_data$CountryName

school_closing_data <- african_data[, names(african_data) %in% c("Date", "CountryName", "School Status")]

school_closing_data <- school_closing_data[complete.cases(school_closing_data), ]

school_closing_data$CountryName <- factor(school_closing_data$CountryName,levels=rev(unique(school_closing_data$CountryName)))

school_closing_data <- school_closing_data[school_closing_data$Date > "2020-02-14", ]

ggplot(school_closing_data, aes(x = Date, y = CountryName, fill = `School Status`)) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
    geom_tile() +
    scale_fill_gradientn(
#        colours = c("gray81", "lightblue1", "#0066CC"),
        colours = c("gray81", "lightblue1", "#0066CC", "navyblue"), #j orig
        limits = c(0, 3),
        oob = squish) +
    labs(x = "", y = "") +
    scale_x_date(date_breaks = "2 weeks", date_labels = "%b-%d")


ggsave("./school_status_heatmap.pdf", width = 15, height = 8.67)
