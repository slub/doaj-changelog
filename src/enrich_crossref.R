# nolint start: line_length_linter.

crossref_journals <- readr::read_csv("http://ftp.crossref.org/titlelist/titleFile.csv", show_col_types = FALSE)
crossref_journals$eissn <- gsub("-", "", crossref_journals$eissn)
crossref_journals$pissn <- gsub("-", "", crossref_journals$pissn)
crossref_journals$additionalIssns <- gsub("-", "", crossref_journals$additionalIssns)
crossref_journals_issns <- sort(unique(c(
  crossref_journals$eissn[!is.na(crossref_journals$eissn)],
  crossref_journals$pissn[!is.na(crossref_journals$pissn)],
  unlist(strsplit(crossref_journals$additionalIssns[!is.na(crossref_journals$additionalIssns)], "; "))
)))
crossref_journals_issns <- crossref_journals_issns[nchar(crossref_journals_issns) == 8]

doaj_withdrawn_issns <- jsonlite::read_json("data/doaj_changelog_withdrawn_list_issns_all.json", simplifyVector = TRUE)
doaj_withdrawn_issns <- gsub("-", "", doaj_withdrawn_issns)
doaj_withdrawn_issns_crossref <- doaj_withdrawn_issns[doaj_withdrawn_issns %in% crossref_journals_issns]

doaj_withdrawn_crossref_df <- unique(do.call("rbind", lapply(doaj_withdrawn_issns_crossref, function(x) {
  crossref_journals[grepl(x, crossref_journals$eissn, ignore.case = TRUE) | grepl(x, crossref_journals$pissn, ignore.case = TRUE) | grepl(x, crossref_journals$additionalIssns, ignore.case = TRUE), ]
})))

doaj_withdrawn_crossref_target <- doaj_withdrawn_crossref_df[, c(
  "JournalID",
  "JournalTitle",
  "Publisher",
  "eissn",
  "pissn",
  "additionalIssns"
)]
doaj_withdrawn_crossref_target <- doaj_withdrawn_crossref_target[order(doaj_withdrawn_crossref_target$JournalID), ]
doaj_withdrawn_crossref_target[grepl("^$", doaj_withdrawn_crossref_target$Publisher), ] <- NA

issn_pattern <- "([[:digit:]]{4})([[:digit:]]{3}[[:digit:]xX])"
doaj_withdrawn_crossref_target$eissn <- gsub(issn_pattern, "\\1-\\2", doaj_withdrawn_crossref_target$eissn)
doaj_withdrawn_crossref_target$pissn <- gsub(issn_pattern, "\\1-\\2", doaj_withdrawn_crossref_target$pissn)
doaj_withdrawn_crossref_target$additionalIssns <- gsub(issn_pattern, "\\1-\\2", doaj_withdrawn_crossref_target$additionalIssns)

readr::write_csv(doaj_withdrawn_crossref_target, "data/doaj_changelog_withdrawn_list_via_crossref.csv", na = "")

# nolint end
