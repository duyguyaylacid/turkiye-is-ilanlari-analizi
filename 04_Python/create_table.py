import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, text

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

DATABASE_URL = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(DATABASE_URL)

create_table_sql = """
CREATE TABLE IF NOT EXISTS turkiye_is_ilanlari (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kategori VARCHAR(100),
    pozisyon VARCHAR(255),
    sirket VARCHAR(255),
    sehir VARCHAR(100),
    ilan_tarihi DATE,
    calisma_tipi VARCHAR(50),
    deneyim_seviyesi VARCHAR(100),
    maas VARCHAR(100),
    basvuran_sayisi INTEGER,
    aciklama TEXT,
    link TEXT
);
"""

try:
    with engine.begin() as connection:
        connection.execute(text(create_table_sql))

    print("Tablo başarıyla oluşturuldu!")

except Exception as e:
    print("Tablo oluşturulurken hata oluştu!")
    print(f"Hata: {e}")