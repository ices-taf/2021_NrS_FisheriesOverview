# Initial formatting of the data

library(icesTAF)
library(icesFO)
library(dplyr)

mkdir("data")

# load species list
species_list <- read.taf("bootstrap/data/FAO_ASFIS_species/species_list.csv")
sid <- read.taf("bootstrap/data/ICES_StockInformation/sid.csv")


# 1: ICES official catch statistics

hist <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_historical_catches.csv")
official <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_2006_2019_catches.csv")
prelim <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_preliminary_catches.csv")

catch_dat <-
  format_catches(2021, "Greater North Sea",
    hist, official, prelim, species_list, sid)

write.taf(catch_dat, dir = "data", quote = TRUE)


# 2: SAG
sag_sum <- read.taf("bootstrap/data/SAG_data/SAG_summary.csv")
sag_refpts <- read.taf("bootstrap/data/SAG_data/SAG_refpts.csv")
sag_status <- read.taf("bootstrap/data/SAG_data/SAG_status.csv")

<<<<<<< HEAD
clean_sag <- format_sag(summary, refpts, 2021, "Greater North Sea")
clean_sag <- unique(clean_sag)
clean_status <- format_sag_status(status, 2020, "Greater North Sea")
=======
clean_sag <- format_sag(sag_sum, sag_refpts, 2021, "Greater North Sea")
clean_sag <- unique(clean_sag)
clean_status <- format_sag_status(sag_status, 2021, "Greater North Sea")
>>>>>>> becf649436a609adb71fbd30c156db050dc615da


write.taf(clean_sag, dir = "data")
write.taf(clean_status, dir = "data", quote = TRUE)

# 3: STECF effort and landings

effort <- read.taf("bootstrap/initial/data/Effort-by-country.csv", check.names = TRUE)
names(effort)
effort$sub.region <- tolower(effort$sub.region)
unique(effort$sub.region)
effort_NrS <- dplyr::filter(effort, grepl("27.4.a|27.4.b|27.4.c|27.4.d|27.4.e", sub.region))





landings1 <- read.taf("bootstrap/initial/data/Catches-by-country-2018.csv", check.names = TRUE)
landings2 <- read.taf("bootstrap/initial/data/Catches-by-country-2017.csv", check.names = TRUE)
landings3 <- read.taf("bootstrap/initial/data/Catches-by-country-2016.csv", check.names = TRUE)
landings4 <- read.taf("bootstrap/initial/data/Catches-by-country-2015.csv", check.names = TRUE)
landings <- rbind(landings1, landings2, landings3, landings4)
names(landings)
landings$sub.region <- tolower(landings$sub.region)
landings_NrS <- dplyr::filter(landings, grepl("27.4.a|27.4.b|27.4.c|27.4.d|27.4.e", sub.region))

# need to group gears, Sarah help.
unique(landings_NrS$gear.type)
unique(effort_NrS$gear.type)

landings_NrS <- dplyr::mutate(landings_NrS, gear_class = case_when(
        grepl("TBB", gear.type) ~ "Beam trawl",
        grepl("DRB|DRH|HMD", gear.type) ~ "Dredge",
        grepl("GNS|GND|GTN|LHP|LLS|FPN|GTR|FYK|LLD|SDN|LTL|LNB", gear.type) ~ "Static/Gill net/LL",
        grepl("OTT|OTB|PTB|SSC|SB|SPR|SV", gear.type) ~ "Otter trawl/seine",
        grepl("PTM|OTM|PS", gear.type) ~ "Pelagic trawl/seine",
        grepl("FPO", gear.type) ~ "Pots",
        grepl("NK|NO|LHM", gear.type) ~ "other",
        is.na(gear.type) ~ "other",
        TRUE ~ "other"
)
)

effort_NrS <- dplyr::mutate(effort_NrS, gear_class = case_when(
        grepl("TBB", gear.type) ~ "Beam trawl",
        grepl("DRB|DRH|HMD", gear.type) ~ "Dredge",
        grepl("GNS|GND|GTN|LHP|LLS|FPN|GTR|FYK|LLD|SDN|LTL|LNB", gear.type) ~ "Static/Gill net/LL",
        grepl("OTT|OTB|PTB|SSC|SB|SPR|SV", gear.type) ~ "Otter trawl/seine",
        grepl("PTM|OTM|PS", gear.type) ~ "Pelagic trawl/seine",
        grepl("FPO", gear.type) ~ "Pots",
        grepl("NK|NO|LHM", gear.type) ~ "other",
        is.na(gear.type) ~ "other",
        TRUE ~ "other"
)
)

unique(landings_NrS[c("gear.type", "gear_class")])
unique(effort_NrS[c("gear.type", "gear_class")])

