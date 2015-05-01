# Load the needed libraries
if(!require("data.table")) {
  stop('Cannot find data.table package')
}
if(!require("dplyr")) {
  stop('Cannot find dplyr package')
}
if(!require("lubridate")) {
  stop('Cannot find lubridate package')
}

# Read the data file, if we haven't already
if(!"read_power_data" %in% ls()) {
  source("read_power_data.R")
}
if(!"feb_pwr" %in% ls()) {
  feb_pwr <- read_power_data("household_power_consumption.txt", 
                             c("1/2/2007", "2/2/2007"))
}

# Open the png file
png(filename = "plot1.png", width = 480, height = 480)

# Create and write the plot
with(feb_pwr, 
     hist(feb_pwr$Global_active_power, 
          col = "red", 
          main = "Global Active Power", 
          xlab = "Global Active Power (kilowatts)"))

# Close the file
dev.off()
