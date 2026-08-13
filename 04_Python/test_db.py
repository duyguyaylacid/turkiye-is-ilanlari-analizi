import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# .env dosyasını yükle
load_dotenv()

# PostgreSQL bağlantı bilgileri
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

# Bağlantı adresi
DATABASE_URL = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

# Engine oluştur
engine = create_engine(DATABASE_URL)

# Bağlantıyı test et
try:
    with engine.connect() as connection:
        result = connection.execute(text("SELECT version();"))
        version = result.fetchone()[0]

        print("PostgreSQL bağlantısı başarılı!")
        print(f"Veritabanı: {DB_NAME}")
        print(f"PostgreSQL: {version}")

except Exception as e:
    print("PostgreSQL bağlantısı başarısız!")
    print(f"Hata: {e}")