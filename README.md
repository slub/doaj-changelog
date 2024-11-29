# DOAJ Changelog

The change logs of journals that have been withdrawn from the DOAJ do not contain any publisher information. The aim of this project is to enrich this information.

The final result of the enrichment process is available in [CSV](data/doaj_changelog_withdrawn_list_enriched_utf8.csv) and [XLSX](data/doaj_changelog_withdrawn_list_enriched_utf8.xlsx) format.

Please note that these files are UTF-8 encoded and that there is also an [ASCII](data/doaj_changelog_withdrawn_list_enriched_ascii.csv) version of the CSV file. All characters outside the ASCII range are represented there with UTF-8 escape sequences.

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
# output results as csv
utils/unite
```

## Data Sources

### DOAJ (Google Sheets)

License: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) ([DOAJ Terms](https://doaj.org/terms/))  
Access: [https://docs.google.com/spreadsheets/d/1Kv3MbgFSgtSDnEGkA2JacrSjunRu0umHeZCtcMeqO5E](https://docs.google.com/spreadsheets/d/1Kv3MbgFSgtSDnEGkA2JacrSjunRu0umHeZCtcMeqO5E/edit?gid=2104690845)  

### CIEPS (JSON-LD)

License: ...  
Access: [https://portal.issn.org](https://portal.issn.org/)
