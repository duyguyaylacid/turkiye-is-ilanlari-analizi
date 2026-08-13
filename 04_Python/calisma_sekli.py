import pandas as pd

file = "02_Temiz_Veriler/is_ilanlari_temiz.xlsx"

df = pd.read_excel(file)

def calisma_sekli(row):
    text = (
        str(row["Çalışma Tipi"]) + " " +
        str(row["Açıklama"])
    ).lower()

    if "remote" in text or "uzaktan" in text:
        return "Remote"

    if "hybrid" in text or "hibrit" in text:
        return "Hybrid"

    if "on-site" in text or "onsite" in text or "ofis" in text:
        return "On-site"

    return "Belirsiz"

df["Çalışma Şekli"] = df.apply(calisma_sekli, axis=1)

df.to_excel(file, index=False)

print("Çalışma şekli eklendi.")
print(df["Çalışma Şekli"].value_counts())