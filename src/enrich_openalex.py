import csv
import json
from urllib.request import Request, urlopen
from urllib.error import HTTPError

API_URL = "https://api.openalex.org/sources?filter=issn:%s"

with open("data/doaj_changelog_withdrawn_list_issns_all.json") as f:
    issns = json.load(f)

metadata = [["openalex_id", "issn", "issn_l", "is_in_doaj", "is_core", "publisher_id", "publisher"]]

for issn in issns:
    ids = []
    issn_l = []
    publisher = []
    publisher_id = []
    is_core = []
    is_in_doaj = []
    records = None
    req = Request(API_URL % issn)
    req.add_header("User-Agent", "slub/doaj-changelog mailto:bibliometrie@slub-dresden.de")
    try:
        with urlopen(req) as response:
            if response.code == 200:
                payload = response.read()
                openalex_s = json.loads(payload)
                if openalex_s["meta"]["count"] > 0:
                    records = openalex_s["results"]
                    for record in records:
                        rec_id = record["id"].replace("https://openalex.org/", "")
                        if rec_id not in ids:
                            ids.append(rec_id)
                        if "host_organization_name" in record and \
                                isinstance(record["host_organization_name"], str) and \
                                record["host_organization_name"] not in publisher:
                            publisher.append(record["host_organization_name"])
                        if "host_organization" in record and \
                                isinstance(record["host_organization"], str):
                            host_organization = record["host_organization"].replace("https://openalex.org/", "")
                            if host_organization not in publisher_id:
                                publisher_id.append(host_organization)
                        if "issn_l" in record and record["issn_l"] not in issn_l:
                            issn_l.append(record["issn_l"])
                        if "is_core" in record and str(record["is_core"]) not in is_core:
                            is_core.append(str(record["is_core"]))
                        if "is_in_doaj" in record and str(record["is_in_doaj"]) not in is_in_doaj:
                            is_in_doaj.append(str(record["is_in_doaj"]))
                else:
                    print("ISSN", issn, "could not be found in OpenAlex.")
        if records is not None:
            id_str = "|".join(ids)
            publisher_str = "|".join(publisher)
            publisher_id_str = "|".join(publisher_id)
            issn_l_str = "|".join(issn_l)
            is_core_str = "|".join(is_core)
            is_in_doaj_str = "|".join(is_in_doaj)
            row = [id_str, issn, issn_l_str, is_in_doaj_str, is_core_str, publisher_id_str, publisher_str]
            if row not in metadata:
                metadata.append(row)
    except HTTPError:
        print("Failed to read from URL", API_URL % issn)

with open("data/doaj_changelog_withdrawn_list_via_openalex.csv", "w") as f:
    writer = csv.writer(f)
    writer.writerows(metadata)
