taf.library(icesFO)


summary <- load_sag_summary(2020)
write.taf(summary, file = "bootstrap/data/SAG_data/SAG_summary.csv")

refpts <- load_sag_refpts(2020)
write.taf(refpts, file = "bootstrap/data/SAG_data/SAG_refpts.csv")

status <- load_sag_status(2020)
write.taf(status, file = "bootstrap/data/SAG_data/SAG_status.csv", quote = TRUE)
