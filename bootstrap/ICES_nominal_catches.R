# wd: bootstrap/data/ICES_nominal_catches

library(icesTAF)
taf.library(icesFO)

hist <- load_historical_catches()
write.taf(hist, file = "ICES_historical_catches.csv", quote = TRUE)

official <- load_official_catches()
write.taf(official, file = "ICES_2006_2019_catches.csv", quote = TRUE)

prelim <- load_preliminary_catches(2020)
<<<<<<< HEAD
write.taf(preliminary, file = "ICES_preliminary_catches.csv", quote = TRUE)
=======
write.taf(prelim, file = "ICES_preliminary_catches.csv", quote = TRUE)
>>>>>>> becf649436a609adb71fbd30c156db050dc615da


