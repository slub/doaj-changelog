# DOAJ Changelog

License: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) ([DOAJ Terms](https://doaj.org/terms/))  
Access via Google Docs: [https://docs.google.com/spreadsheets/d/1Kv3MbgFSgtSDnEGkA2JacrSjunRu0umHeZCtcMeqO5E](https://docs.google.com/spreadsheets/d/1Kv3MbgFSgtSDnEGkA2JacrSjunRu0umHeZCtcMeqO5E/edit?usp=sharing)  

## Workflow

### One-time

```sh
# export sheets as csv
utils/archive
```

### Periodically

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
