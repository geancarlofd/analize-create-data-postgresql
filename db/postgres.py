import psycopg2
from utils.config import get_db_config

def get_connection():
    config = get_db_config()
    return psycopg2.connect(
        host=config["host"],
        port=config["port"],
        dbname=config["name"],
        user=config["user"],
        password=config["password"]
    )
