from db.postgres import get_connection
from core.extractor import extract_schema
from core.dictionary_builder import build_dictionary
from core.exporter import export_to_json, export_to_csv

def main():
    conn = get_connection()
    cursor = conn.cursor()

    schema_data = extract_schema(cursor)
    data_dict = build_dictionary(schema_data)

    # Exporta para JSON e CSV
    export_to_json(data_dict)
    export_to_csv(data_dict)

    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()
