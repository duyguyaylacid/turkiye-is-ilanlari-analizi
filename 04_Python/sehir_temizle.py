import pandas as pd

file = "02_Temiz_Veriler/is_ilanlari_temiz.xlsx"

df = pd.read_excel(file)

df["Şehir"] = (
    df["Şehir"]
    .fillna("Belirtilmemiş")
    .astype(str)
    .str.strip()
)

df.loc[
    df["Şehir"].str.contains("istanbul", case=False, na=False),
    "Şehir"
] = "İstanbul"

df.loc[
    df["Şehir"].str.contains("ankara", case=False, na=False),
    "Şehir"
] = "Ankara"

df.loc[
    df["Şehir"].str.contains("izmir", case=False, na=False),
    "Şehir"
] = "İzmir"

df.to_excel(file, index=False)

print("Şehirler standartlaştırıldı.")