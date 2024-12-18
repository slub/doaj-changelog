# nolint start: line_length_linter.

# Mapping by @MiWohlgemuth

not_best_practice <- c(
  "adhere to best practice",
  "adhering to Best practice",
  "does not satisfy basic criteria",
  "fake impact factor",
  "Suspected editorial misconduct by society"
)

inactive_publication <- c(
  "Ceased",
  "Deactivated by current publisher",
  "Inactive",
  "Journal ceased",
  "No issue published",
  "Other; no content",
  "stopped publishing"
)

changed_publisher <- c(
  "Changed publisher",
  "no longer published by Sciendo"
)

not_enough_output <- c(
  "Not enough articles",
  "not published enough articles"
)

not_open_access <- c(
  "Journal is no longer open access",
  "licence",
  "license",
  "licensing",
  "No longer OA",
  "No longer open access",
  "not open access",
  "not Open Access",
  "Other; delayed open access",
  "OA statement",
  "Requires user registration"
)

website_problems <- c(
  "Incorrect Website URL",
  "Malicious website",
  "Other; taken offline",
  "Other:website closed by publisher",
  "site not secure",
  "Site not secure",
  "site under reconstruction",
  "site unstable",
  "web site url no longer works",
  "Web site url no longer works",
  "Web site URL will change",
  "Website URL no longer works",
  "Website URLs have security issues",
  "Website URLs no longer work"
)

other_reasons <- c(
  "application form no info",
  "book reviews only",
  "no answer",
  "No communication",
  "No editorial board",
  "No longer scholarly journal",
  "Not a research journal",
  "Not complying to the BOAI",
  "Not in the issn database",
  "Publisher failed to respond to requests for information",
  "Publisher will not submit a new application within the given time period for reapplications",
  "Removed at publisher's request",
  "the issn 20888708 given by editor leads to another journal",
  "the print title was added to Doaj"
)

reasons <- list(
  "not_best_practice" = paste0(not_best_practice, collapse = "|"),
  "inactive_publication" = paste0(inactive_publication, collapse = "|"),
  "changed_publisher" = paste0(changed_publisher, collapse = "|"),
  "not_enough_output" = paste0(not_enough_output, collapse = "|"),
  "not_open_access" = paste0(not_open_access, collapse = "|"),
  "website_problems" = paste0(website_problems, collapse = "|"),
  "other_reasons" = paste0(other_reasons, collapse = "|")
)

reasons_out <- list(
  "not_best_practice" = "Journal not adhering to Best practice",
  "inactive_publication" = "Journal is inactive",
  "changed_publisher" = "Changed publisher",
  "not_enough_output" = "Journal has not published enough articles",
  "not_open_access" = "Journal is not open access",
  "website_problems" = "Problems with website",
  "other_reasons" = "Other reasons"
)

parse_reason <- function(reason) {
  result <- paste0(sort(unique(unlist(lapply(names(reasons), function(x) {
    pattern <- reasons[[x]]
    if (grepl(pattern, reason, ignore.case = TRUE)) {
      reasons_out[[x]]
    }
  })))), collapse = "#")
  if (grepl("^$", result)) {
    cat(paste0("No mapping found for reason \"", reason, "\"! Change value to \"", reasons_out[["other_reasons"]], "\".\n"), sep = "")
    reasons_out[["other_reasons"]]
  } else {
    result
  }
}

# debug

unmapped_reasons <- function(reason) {
  reasons_all <- paste0(unname(unlist(reasons)), collapse = "|")
  if (!all(grepl(reasons_all, reason, ignore.case = TRUE))) {
    unique(reason[!grepl(reasons_all, reason, ignore.case = TRUE)])
  }
}

# nolint end
