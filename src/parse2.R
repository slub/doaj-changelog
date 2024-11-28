# nolint start: line_length_linter, commented_code_linter.

#doaj_withdrawn_issns <- jsonlite::read_json("data/doaj_changelog_withdrawn_list_issns.json", simplifyVector = TRUE)
doaj_withdrawn_links <- readr::read_csv("data/doaj_changelog_withdrawn_list_via_cieps.csv", show_col_types = FALSE)
doaj_withdrawn_issn_l <- sort(unique(doaj_withdrawn_links$issn_l))
jsonlite::write_json(doaj_withdrawn_issn_l, "data/doaj_changelog_withdrawn_list_issns_linking.json", pretty = 2)
doaj_withdrawn_all_issns <- sort(unique(unlist(strsplit(doaj_withdrawn_links$all_issns, "\\|"))))
jsonlite::write_json(doaj_withdrawn_all_issns, "data/doaj_changelog_withdrawn_list_issns_all.json", pretty = 2)

# nolint end
