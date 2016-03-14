library(dplyr)

# After taking a look at the file to be read in it can be seen
# that the date of 2007-02-02 has its last line on line number
# 69517. We read in 1 more line just to be sure.
## @knitr read_in_file
household_power_consumption <- 
     read.table("household_power_consumption.txt", 
                sep = ";",
                header = TRUE,
                nrows = 69518,
                na.strings = "?",
                stringsAsFactors = FALSE)

## @knitr format_date_data
household_power_consumption$DateTime <-
     strptime(paste(household_power_consumption$Date, 
                    household_power_consumption$Time), 
               format = "%d/%m/%Y %T",
               tz = "")

household_power_consumption$Date <-
     as.Date(strptime(household_power_consumption$Date, format = "%d/%m/%Y"))

## @knitr filter_hh_power
hh_power_filtered <- 
     subset(household_power_consumption,
            Date == "2007-02-01" | Date == "2007-02-02")

## @knitr write_plot_to_file
png(filename = "plot2.png")
plot(hh_power_filtered$DateTime,
     hh_power_filtered$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off
