# nolint start: line_length_linter.

doaj_withdrawn_target <- readr::read_csv(paste0("data/doaj_changelog_withdrawn_list.csv"), show_col_types = FALSE)
doaj_withdrawn_cieps <- readr::read_csv(paste0("data/doaj_changelog_withdrawn_list_via_cieps.csv"), show_col_types = FALSE)
doaj_withdrawn_crossref <- readr::read_csv(paste0("data/doaj_changelog_withdrawn_list_via_crossref.csv"), show_col_types = FALSE)

doaj_withdrawn_target$`Date Removed (dd/mm/yyyy)` <- unlist(lapply(doaj_withdrawn_target$`Date Removed (dd/mm/yyyy)`, function(x) {
  if (grepl("[[:digit:]]{1,2}-[[:alpha:]]{3,9}-20[12][[:digit:]]", x)) {
    format(as.Date(x, "%d-%B-%Y"), format = "%Y-%m-%d")
  } else if (grepl("12-Aug-0202", x, fixed = TRUE)) {
    "2020-08-12"
  } else if (grepl("Q1, 2014", x, fixed = TRUE)) {
    "2014-03-31"
  } else if (grepl("[[:digit:]]{1,2}/[[:digit:]]{1,2}/[[:digit:]]{4}", x)) {
    if (grepl("8/15/2016", x)) {
      "2016-08-15"
    } else {
      format(as.Date(x, "%d/%m/%Y"), format = "%Y-%m-%d")
    }
  } else {
    x
  }
}))

doaj_withdrawn_target$`ISSN-L` <- unlist(lapply(doaj_withdrawn_target$ISSN, function(x) {
  if (!all(is.na(x))) {
    issns <- unlist(strsplit(x, ", "))
    issns <- issns[unlist(lapply(issns, nchar)) == 9]
    issns <- sort(unique(issns))
    links <- sort(unique(unlist(lapply(issns, function(y) {
      links_found <- sort(unique(doaj_withdrawn_cieps[grepl(y, doaj_withdrawn_cieps$all_issns), ]$issn_l))
      if (!identical(links_found, character(0))) {
        paste(links_found, collapse = "#")
      } else {
        NA
      }
    }))))
    if (!all(is.na(links))) {
      paste(links[!is.na(links)], collapse = "|")
    } else {
      NA
    }
  } else {
    NA
  }
}))

doaj_withdrawn_target$all_issns <- unlist(lapply(doaj_withdrawn_target$`ISSN-L`, function(x) {
  if (!is.na(x)) {
    issns_l <- unique(unlist(strsplit(x, "[#|]")))
    all_issns <- unlist(lapply(x, function(y) {
      doaj_withdrawn_cieps_issns <- doaj_withdrawn_cieps[grepl(y, doaj_withdrawn_cieps$issn_l), ]$all_issns
      if (!identical(doaj_withdrawn_cieps_issns, character(0))) {
        paste(sort(unique(doaj_withdrawn_cieps_issns)), collapse = "|")
      } else {
        NA
      }
    }))
    paste(sort(unique(all_issns)), collapse = "#")
  } else {
    x
  }
}))

doaj_withdrawn_target$publisher <- apply(doaj_withdrawn_target, 1, function(row) {
  issns <- unique(unlist(strsplit(row[2], ", ")))
  if (!is.na(row[6])) {
    issns <- unique(c(unlist(strsplit(row[6], "[#|]")), issns))
  }
  issns <- issns[!is.na(issns)]
  if (!identical(issns, logical(0))) {
    publisher <- unlist(lapply(issns, function(x) {
      doaj_withdrawn_crossref[grepl(x, doaj_withdrawn_crossref$eissn) | grepl(x, doaj_withdrawn_crossref$pissn) | grepl(x, doaj_withdrawn_crossref$additionalIssns), ]$Publisher
    }))
    if (!identical(publisher, character(0))) {
      publisher <- gsub("^\"|\"$", "", publisher)
      paste(sort(unique(publisher)), collapse = "|")
    } else {
      NA
    }
  } else {
    NA
  }
})

doaj_withdrawn_target_publisher <- sort(unique(doaj_withdrawn_target$publisher))
jsonlite::write_json(doaj_withdrawn_target_publisher, "data/doaj_changelog_withdrawn_publisher.json", auto_unbox = TRUE, pretty = 2)
writeLines(sort(unique(doaj_withdrawn_target_publisher)), "data/doaj_changelog_withdrawn_publisher.txt")

doaj_withdrawn_target <- doaj_withdrawn_target[c(
  "Journal Title",
  "publisher",
  "ISSN",
  "ISSN-L",
  "all_issns",
  "Date Removed (dd/mm/yyyy)",
  "Reason"
)]

names(doaj_withdrawn_target) <- c(
  "title",
  "publisher",
  "issn",
  "issn_l",
  "issns",
  "date_removed",
  "reason"
)

doaj_withdrawn_target <- doaj_withdrawn_target[with(doaj_withdrawn_target, order(date_removed, issn_l, issn, decreasing = TRUE)), ]

readr::write_csv(doaj_withdrawn_target, "data/doaj_changelog_withdrawn_list_enriched_utf8.csv", na = "")

doaj_withdrawn_excel <- list(
  "doaj_withdrawn_target" = doaj_withdrawn_target,
  "doaj_withdrawn_cieps" = doaj_withdrawn_cieps,
  "doaj_withdrawn_crossref" = doaj_withdrawn_crossref
)

writexl::write_xlsx(doaj_withdrawn_excel, "data/doaj_changelog_withdrawn_list_enriched_utf8.xlsx")

doaj_withdrawn_target$title <- iconv(doaj_withdrawn_target$title, from = "UTF-8", to = "ASCII", sub = "c99")
doaj_withdrawn_target$publisher <- iconv(doaj_withdrawn_target$publisher, from = "UTF-8", to = "ASCII", sub = "c99")

readr::write_csv(doaj_withdrawn_target, "data/doaj_changelog_withdrawn_list_enriched_ascii.csv", na = "")

# nolint end
