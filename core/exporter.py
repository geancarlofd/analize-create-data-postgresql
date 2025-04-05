import json
import csv
import os

def export_to_json(data_dict, output_path="output/data_dictionary.json"):
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(data_dict, f, indent=2, ensure_ascii=False)
    print(f"✅ Dicionário exportado para JSON: {output_path}")

def export_to_csv(data_dict, output_path="output/data_dictionary.csv"):
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow([
            "Tabela", "Coluna", "Tipo", "Tamanho", 
            "Pode ser nulo?", "Chave Primária", "Chave Estrangeira", "Referência"
        ])
        
        for table, columns in data_dict.items():
            for col in columns:
                writer.writerow([
                    table,
                    col["column"],
                    col["type"],
                    col["length"] or "",
                    col["nullable"],
                    "Sim" if col["is_primary_key"] else "Não",
                    "Sim" if col["is_foreign_key"] else "Não",
                    col["references"] or ""
                ])
    print(f"✅ Dicionário exportado para CSV: {output_path}")

