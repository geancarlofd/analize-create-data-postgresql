def build_dictionary(schema_data):
    dictionary = {}
    for entry in schema_data:
        table = entry["table"]
        if table not in dictionary:
            dictionary[table] = []
        dictionary[table].append({
            "column": entry["column"],
            "type": entry["type"],
            "length": entry["length"],
            "nullable": entry["nullable"],
            "is_primary_key": entry["is_primary_key"],
            "is_foreign_key": entry["is_foreign_key"],
            "references": entry["references"]
        })
    return dictionary
