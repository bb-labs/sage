def prepare_record_sets_for_deletion_by_type(records, types):
    return [
        {"Action": "DELETE", "ResourceRecordSet": record}
        for record in records
        if record["Type"] in types
    ]


def prepare_record_sets_for_upsertion(records):
    return [
        {
            "Action": "UPSERT",
            "ResourceRecordSet": {
                "Name": record["ResourceRecord"]["Name"],
                "Type": record["ResourceRecord"]["Type"],
                "TTL": 300,
                "ResourceRecords": [{"Value": record["ResourceRecord"]["Value"]}],
            },
        }
        for record in records
    ]
