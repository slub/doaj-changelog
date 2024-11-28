import csv
import json
import issnpy
import datetime

today = datetime.date.today().strftime("%Y%m%d")

with open("data/doaj_changelog_withdrawn_list_issns.json") as f:
    issns = json.load(f)

metadata = [["issn", "issn_l", "publisher"]]

for issn in issns:
    record = issnpy.fetch(issn)
    if record is not None:
        issn_l = record.get_issn_l() or ""
        publisher = record.get_publisher() or ""
        metadata.append([issn, issn_l, publisher])

with open("data/doaj_changelog_withdrawn_list_via_cieps.csv", "w") as f:
    writer = csv.writer(f)
    writer.writerows(metadata)
