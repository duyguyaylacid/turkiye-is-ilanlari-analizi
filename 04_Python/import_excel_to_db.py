import os

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine

# .env dosyasını yükle
load_dotenv()

# PostgreSQL bağlantı bilgileri
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

# PostgreSQL bağlantısı
DATABASE_URL = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(DATABASE_URL)

# Excel dosyasını oku
file_path = "01_Ham_Veriler/is_ilanlari_ham.xlsx"

df = pd.read_excel(file_path)

print(f"Excel'den {len(df)} ilan okundu.")

# Excel sütunlarını PostgreSQL sütunlarına uygun hale getir
df = df.rename(columns={
    "Kategori": "kategori",
    "Pozisyon": "pozisyon",
    "Şirket": "sirket",
    "Şehir": "sehir",
    "İlan Tarihi": "ilan_tarihi",
    "Çalışma Tipi": "calisma_tipi",
    "Deneyim Seviyesi": "deneyim_seviyesi",
    "Maaş": "maas",
    "Başvuran Sayısı": "basvuran_sayisi",
    "Açıklama": "aciklama",
    "Link": "link"
})

# Veriyi PostgreSQL'e aktar
df.to_sql(
    "turkiye_is_ilanlari",
    engine,
    if_exists="append",
    index=False
)

print("Excel verileri PostgreSQL'e başarıyla aktarıldı!")
print(f"Aktarılan kayıt sayısı: {len(df)}")