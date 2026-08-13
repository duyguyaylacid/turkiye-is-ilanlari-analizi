import pandas as pd
import os

input_file = "01_Ham_Veriler/is_ilanlari_ham.xlsx"
output_folder = "02_Temiz_Veriler"
output_file = f"{output_folder}/is_ilanlari_temiz.xlsx"

os.makedirs(output_folder, exist_ok=True)

# HAM VERİYİ OKU
df = pd.read_excel(input_file)

print("Ham veri sütunları:")
print(df.columns.tolist())

print(f"\nHam ilan sayısı: {len(df)}")

# Sütun isimlerini temizle
df.columns = df.columns.str.strip()

# Link olmayan kayıtları çıkar
df = df.dropna(subset=["Link"])

# Aynı ilanları kaldır
df = df.drop_duplicates(subset=["Link"])

# Metin alanlarını temizle
text_columns = [
    "Kategori",
    "Pozisyon",
    "Şirket",
    "Şehir",
    "Çalışma Tipi",
    "Deneyim Seviyesi",
    "Maaş",
    "Açıklama"
]

for column in text_columns:
    if column in df.columns:
        df[column] = (
            df[column]
            .fillna("")
            .astype(str)
            .str.strip()
            .str.replace(r"\s+", " ", regex=True)
        )

# Excel'e kaydet
df.to_excel(output_file, index=False)

print(f"\nTemiz ilan sayısı: {len(df)}")
print(f"Temiz veri oluşturuldu: {output_file}")