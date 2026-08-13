import pandas as pd

input_file = "02_Temiz_Veriler/is_ilanlari_temiz.xlsx"
output_file = "02_Temiz_Veriler/is_ilanlari_temiz.xlsx"

df = pd.read_excel(input_file)

def mezun_uygunluk(row):
    deneyim = str(row["Deneyim Seviyesi"]).lower()
    aciklama = str(row["Açıklama"]).lower()

    # Açıkça stajyer / entry level / yeni mezun arayanlar
    if any(x in deneyim for x in [
        "entry level",
        "intern",
        "internship",
        "staj",
        "trainee"
    ]):
        return "Evet"

    if any(x in aciklama for x in [
        "new graduate",
        "new grad",
        "yeni mezun",
        "fresh graduate",
        "entry level"
    ]):
        return "Evet"

    # Açıkça deneyim isteyenler
    if any(x in deneyim for x in [
        "director",
        "executive",
        "manager",
        "senior",
        "lead",
        "principal"
    ]):
        return "Hayır"

    # Associate / belirsiz ilanları "Belirsiz" bırak
    return "Belirsiz"


df["Yeni Mezuna Uygun mu?"] = df.apply(
    mezun_uygunluk,
    axis=1
)

df.to_excel(output_file, index=False)

print("Yeni mezun uygunluk analizi tamamlandı.")
print(df["Yeni Mezuna Uygun mu?"].value_counts())