def extract_schema(cursor):
    # 1. Pegando colunas com tipos e nulabilidade
    cursor.execute("""
        SELECT 
            table_name, 
            column_name, 
            data_type, 
            is_nullable,
            character_maximum_length
        FROM information_schema.columns
        WHERE table_schema = 'public'
        ORDER BY table_name, ordinal_position;
    """)
    columns = cursor.fetchall()

    # 2. Pegando chaves primárias
    cursor.execute("""
        SELECT 
            kcu.table_name, 
            kcu.column_name
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu
          ON tc.constraint_name = kcu.constraint_name
        WHERE tc.constraint_type = 'PRIMARY KEY'
          AND tc.table_schema = 'public';
    """)
    pk_columns = {(table, col) for table, col in cursor.fetchall()}

    # 3. Pegando chaves estrangeiras e suas referências
    cursor.execute("""
        SELECT 
            tc.table_name,
            kcu.column_name,
            ccu.table_name AS foreign_table_name,
            ccu.column_name AS foreign_column_name
        FROM 
            information_schema.table_constraints AS tc
        JOIN information_schema.key_column_usage AS kcu
          ON tc.constraint_name = kcu.constraint_name
        JOIN information_schema.constraint_column_usage AS ccu
          ON ccu.constraint_name = tc.constraint_name
        WHERE tc.constraint_type = 'FOREIGN KEY'
          AND tc.table_schema = 'public';
    """)
    fk_map = {}
    for table, col, ref_table, ref_col in cursor.fetchall():
        fk_map[(table, col)] = f"{ref_table}.{ref_col}"

    # 4. Montando estrutura unificada
    final_data = []
    for table, col, dtype, nullable, char_len in columns:
        final_data.append({
            "table": table,
            "column": col,
            "type": dtype,
            "nullable": nullable,
            "length": char_len,
            "is_primary_key": (table, col) in pk_columns,
            "is_foreign_key": (table, col) in fk_map,
            "references": fk_map.get((table, col))
        })

    return final_data
