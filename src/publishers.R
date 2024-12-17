# Mapping by @MiWohlgemuth

de_gruyter_brill <- c(
  "De Gruyter",
  "Brill",
  "Vandenhoeck",
  "Sciendo"
)

elsevier <- c(
  "Elsevier",
  "KeAi Comm"
)

frontiers <- c(
  "Frontiers Media"
)

informa <- c(
  "Taylor & Francis",
  "Dove Medical"
)

mdpi <- c(
  "MDPI"
)

oxford <- c(
  "Oxford University"
)

sage <- c(
  "SAGE ",
  "Mary Ann Liebert"
)

springer_nature <- c(
  "Springer",
  "Biomed Central"
)

wolters_kluwer <- c(
  "Medknow Publ",
  "Wolters Kluwer"
)

wiley <- c(
  "Wiley",
  "Hindawi"
)

publishers <- list(
  "de_gruyter_brill" = paste0(de_gruyter_brill, collapse = "|"),
  "elsevier" = paste0(elsevier, collapse = "|"),
  "frontiers" = paste0(frontiers, collapse = "|"),
  "informa" = paste0(informa, collapse = "|"),
  "mdpi" = paste0(mdpi, collapse = "|"),
  "oxford" = paste0(oxford, collapse = "|"),
  "sage" = paste0(sage, collapse = "|"),
  "springer_nature" = paste0(springer_nature, collapse = "|"),
  "wolters_kluwer" = paste0(wolters_kluwer, collapse = "|"),
  "wiley" = paste0(wiley, collapse = "|")
)

publishers_out <- list(
  "de_gruyter_brill" = "De Gruyter Brill",
  "elsevier" = "Elsevier",
  "frontiers" = "Frontiers",
  "informa" = "Taylor & Francis",
  "mdpi" = "MDPI",
  "oxford" = "Oxford University Press",
  "sage" = "SAGE",
  "springer_nature" = "Springer Nature",
  "wolters_kluwer" = "Wolters Kluwer",
  "wiley" = "Wiley"
)

parse_publisher <- function(publisher) {
  result <- paste0(sort(unique(unlist(lapply(names(publishers), function(x) {
    pattern <- publishers[[x]]
    if (grepl(pattern, publisher, ignore.case = TRUE)) {
      publishers_out[[x]]
    }
  })))), collapse = "#")
  if (grepl("^$", result)) {
    publisher
  } else {
    result
  }
}
