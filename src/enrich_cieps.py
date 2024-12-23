import csv
import json
import issnpy

with open("data/doaj_changelog_withdrawn_list_issns.json") as f:
    issns = json.load(f)

links = []
metadata = [["issn_l", "eissn", "pissn", "all_issns"]]

for issn in issns:
    record = issnpy.fetch(issn)
    if record is not None:
        link = record.get_issn_l()
        if link is not None and link not in links:
            links.append(link)
            eissns = []
            pissns = []
            allissns = [issn, link]
            record = issnpy.fetch(link, link=True)
            if record is not None:
                related_issns = record.get_issns()
                if isinstance(related_issns, list):
                    for related_issn in related_issns:
                        if related_issn["format"] == "Online":
                            eissns.append(related_issn["id"])
                        elif related_issn["format"] == "Print":
                            pissns.append(related_issn["id"])
                        if related_issn["id"] not in allissns:
                            allissns.append(related_issn["id"])
            eissns = list(set(eissns))
            eissns.sort()
            eissns = "|".join(eissns)
            pissns = list(set(pissns))
            pissns.sort()
            pissns = "|".join(pissns)
            allissns = list(set(allissns))
            allissns.sort()
            allissns = "|".join(allissns)
            metadata.append([link, eissns, pissns, allissns])

with open("data/doaj_changelog_withdrawn_list_via_cieps.csv", "w") as f:
    writer = csv.writer(f)
    writer.writerows(metadata)
