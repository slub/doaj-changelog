# DOAJ Changelog

The change log showing journals that have been withdrawn from the [Directory of Open Access Journals](https://doaj.org/) (DOAJ) does not contain any publisher information. The aim of this project is to enrich these.

The final result of the enrichment process is available in [CSV](data/doaj_changelog_withdrawn_list_enriched_utf8.csv) and [XLSX](data/doaj_changelog_withdrawn_list_enriched_utf8.xlsx) format.

Please note that these files are UTF-8 encoded and that there is also an [ASCII](data/doaj_changelog_withdrawn_list_enriched_ascii.csv) version of the CSV file in which all characters outside the ASCII range are represented as Unicode escape sequences.

## Workflow

### One-time

```sh
# export sheets as csv
utils/archive
```

### Periodic

```sh
# export sheets as csv
utils/refresh
```

```sh
# output list as json
utils/parse
```

```sh
# enrich via json api
utils/enrich_cieps
```

```sh
# output list as json
utils/parse2
```

```sh
# enrich via csv
utils/enrich_crossref
```

```sh
# output results as csv
utils/unite
```

## Data Sources

### DOAJ (CSV)

License: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) ([Terms](https://doaj.org/terms/))  
Access: [Google Sheets](https://docs.google.com/spreadsheets/d/183mRBRqs2jOyP0qZWXN8dUd02D4vL0Mov_kgYF8HORM/edit#gid=1650882189) (2014–2024) / [Google Sheets](https://docs.google.com/spreadsheets/d/1Kv3MbgFSgtSDnEGkA2JacrSjunRu0umHeZCtcMeqO5E/edit?gid=2104690845) (2024-)  

### CIEPS (JSON-LD)

License: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) ([Terms](https://portal.issn.org/content/cgu))  
Access: [ISSN Portal](https://portal.issn.org/)  

### Crossref (CSV)

License: “Facts, not subject to copyright” / [CC0](https://creativecommons.org/publicdomain/zero/1.0/) ([Terms](https://www.crossref.org/documentation/retrieve-metadata/rest-api/rest-api-metadata-license-information/))  
Access: [Journal Coverage List](https://www.crossref.org/documentation/reports/browsable-title-list/)  

## Licenses

The code in this repository is made available under [GPL-3.0](LICENSE-CODE).

The data in this repository is made available under [CC-BY-SA-4.0](LICENSE).

## Acknowledgement

We thank the [ISSN International Centre](https://www.issn.org/) for resolving the conflict between the licenses for their data and those of the DOAJ by waiving the NonCommercial (“NC”) element for this project.
