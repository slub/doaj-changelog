# nolint start: line_length_linter, brace_linter, object_length_linter, commented_code_linter.

#doaj_withdrawn <- readr::read_csv("https://docs.google.com/spreadsheets/d/1Kv3MbgFSgtSDnEGkA2JacrSjunRu0umHeZCtcMeqO5E/export?format=csv&gid=2104690845", show_col_types = FALSE, skip = 6)
doaj_withdrawn <- readr::read_csv("data/doaj_changelog_withdrawn_latest.csv", show_col_types = FALSE, skip = 6)
doaj_withdrawn <- doaj_withdrawn[!apply(doaj_withdrawn, 1, function(row) { all(is.na(row)) }), ]
#doaj_withdrawn_archive <- readr::read_csv("https://docs.google.com/spreadsheets/d/183mRBRqs2jOyP0qZWXN8dUd02D4vL0Mov_kgYF8HORM/export?format=csv&gid=1650882189", show_col_types = FALSE, skip = 6)
doaj_withdrawn_archive <- readr::read_csv("data/doaj_changelog_withdrawn_archive.csv", show_col_types = FALSE, skip = 6)
doaj_withdrawn_archive <- doaj_withdrawn_archive[!apply(doaj_withdrawn_archive, 1, function(row) { all(is.na(row)) }), ]
doaj_withdrawn <- rbind(doaj_withdrawn, doaj_withdrawn_archive)
doaj_withdrawn$`Journal Title` <- gsub("^[[:space:]]|[[:space:]]$", "", doaj_withdrawn$`Journal Title`)
doaj_withdrawn$Reason <- gsub("^[[:space:]]|[[:space:]]$", "", doaj_withdrawn$Reason)
doaj_withdrawn$ISSN <- gsub("^ | $| |﻿", "", doaj_withdrawn$ISSN)
doaj_withdrawn$ISSN <- gsub(" (old ISSN: 2336-0313)", ", 2336-0313", doaj_withdrawn$ISSN, fixed = TRUE)
readr::write_csv(doaj_withdrawn, "data/doaj_changelog_withdrawn_list.csv", na = "")
doaj_withdrawn_reason <- table(doaj_withdrawn$Reason)
doaj_withdrawn_reason <- doaj_withdrawn_reason[order(doaj_withdrawn_reason, decreasing = TRUE)]
doaj_withdrawn_reason_df <- setNames(as.data.frame(doaj_withdrawn_reason), c("Reason", "Count"))
jsonlite::write_json(doaj_withdrawn_reason_df, "data/doaj_changelog_withdrawn_stats.json", auto_unbox = TRUE, pretty = 2)

doaj_withdrawn_issns <- unlist(strsplit(doaj_withdrawn$ISSN, ", "))
doaj_withdrawn_issns <- doaj_withdrawn_issns[unlist(lapply(doaj_withdrawn_issns, nchar)) == 9]
doaj_withdrawn_issns <- sort(unique(doaj_withdrawn_issns))
jsonlite::write_json(doaj_withdrawn_issns, paste0("data/doaj_changelog_withdrawn_list_issns.json"), pretty = 2)

# nolint end
