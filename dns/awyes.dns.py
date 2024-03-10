def filter_resource_record_sets_for_deletion(records, types):
    return [
        {"Action": "DELETE", "ResourceRecordSet": record}
        for record in records
        if record["Type"] in types
    ]
