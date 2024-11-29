# DOAJ Changelog

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
