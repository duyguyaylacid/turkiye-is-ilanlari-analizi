from pathlib import Path
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Grafik görünümü
sns.set_theme(style="whitegrid")
plt.rcParams["figure.figsize"] = (10, 6)

# 1) Veri dosyasını oku
PROJE_KLASORU = Path(__file__).resolve().parent.parent
VERI_DOSYASI = PROJE_KLASORU / "02_Temiz_Veriler" / "is_ilanlari_temiz.xlsx"

if VERI_DOSYASI.suffix.lower() == ".csv":
    df = pd.read_csv(VERI_DOSYASI)
elif VERI_DOSYASI.suffix.lower() in [".xlsx", ".xls"]:
    df = pd.read_excel(VERI_DOSYASI)
else:
    raise ValueError("Dosya türü CSV veya Excel olmalıdır.")

# 2) Veriyi tanı
print("\n--- VERİ SETİ ÖZETİ ---")
print(f"Satır sayısı: {df.shape[0]}")
print(f"Sütun sayısı: {df.shape[1]}")
print("\nSütunlar:")
print(df.columns.tolist())

print("\nVeri türleri ve eksik değerler:")
print(df.info())

print("\nEksik değer sayıları:")
print(df.isnull().sum().sort_values(ascending=False))

print("\nİlk 5 kayıt:")
print(df.head())

print("\nSayısal sütunların özeti:")
print(df.describe())

# 3) Temel temizlik
tekrar_sayisi = df.duplicated().sum()
print(f"\nTekrar eden kayıt sayısı: {tekrar_sayisi}")

df = df.drop_duplicates()

# Tamamen boş sütunları kaldır
tamamen_bos_sutunlar = df.columns[df.isna().all()].tolist()

if tamamen_bos_sutunlar:
    print(f"\nTamamen boş sütunlar: {tamamen_bos_sutunlar}")
    print("Bu sütunlar veri kalitesi bilgisi için korunacak; analizde kullanılmayacak.")

# 4) Temiz veriyi kaydet
cikti_klasoru = PROJE_KLASORU / "09_Ciktilar" / "Python_Analizi"
cikti_klasoru.mkdir(parents=True, exist_ok=True)

df.to_csv(cikti_klasoru / "temizlenmis_veri_python.csv", index=False)
print("\nTemizlenmiş veri kaydedildi.")

# 5) Eksik değer grafiği
eksikler = df.isnull().sum()
eksikler = eksikler[eksikler > 0].sort_values(ascending=False)

if not eksikler.empty:
    plt.figure()
    sns.barplot(x=eksikler.values, y=eksikler.index, color="steelblue")
    plt.title("Sütunlara Göre Eksik Değer Sayısı")
    plt.xlabel("Eksik Değer Sayısı")
    plt.ylabel("Sütun")
    plt.tight_layout()
    plt.savefig(cikti_klasoru / "eksik_degerler.png", dpi=150)
    plt.show()
else:
    print("Eksik değer bulunamadı; eksik değer grafiği oluşturulmadı.")


# 6) Keşifsel Veri Analizi (EDA) grafikleri

# Kategoriye göre ilan sayısı
plt.figure()
kategori_sayilari = df["Kategori"].value_counts()
sns.barplot(x=kategori_sayilari.values, y=kategori_sayilari.index, color="steelblue")
plt.title("Kategoriye Göre İlan Sayısı")
plt.xlabel("İlan Sayısı")
plt.ylabel("Kategori")
plt.tight_layout()
plt.savefig(cikti_klasoru / "kategoriye_gore_ilan_sayisi.png", dpi=150)
plt.close()

# Şehre göre ilk 10 ilan yoğunluğu
plt.figure()
sehir_sayilari = df["Şehir"].value_counts().head(10)
sns.barplot(x=sehir_sayilari.values, y=sehir_sayilari.index, color="teal")
plt.title("Şehre Göre İlk 10 İlan Yoğunluğu")
plt.xlabel("İlan Sayısı")
plt.ylabel("Şehir")
plt.tight_layout()
plt.savefig(cikti_klasoru / "sehire_gore_ilan_sayisi.png", dpi=150)
plt.close()

# Deneyim seviyesine göre ilanlar
plt.figure()
deneyim_sayilari = df["Deneyim Seviyesi"].value_counts()
sns.barplot(x=deneyim_sayilari.index, y=deneyim_sayilari.values, color="darkorange")
plt.title("Deneyim Seviyesine Göre İlanlar")
plt.xlabel("Deneyim Seviyesi")
plt.ylabel("İlan Sayısı")
plt.xticks(rotation=20)
plt.tight_layout()
plt.savefig(cikti_klasoru / "deneyim_seviyesine_gore_ilanlar.png", dpi=150)
plt.close()

# Başvuran sayısının dağılımı
plt.figure()
sns.histplot(df["Başvuran Sayısı"], bins=10, kde=True, color="mediumpurple")
plt.title("Başvuran Sayısı Dağılımı")
plt.xlabel("Başvuran Sayısı")
plt.ylabel("İlan Adedi")
plt.tight_layout()
plt.savefig(cikti_klasoru / "basvuran_sayisi_dagilimi.png", dpi=150)
plt.close()

# Teknik beceri sayısı ile başvuran sayısı ilişkisi
plt.figure()
sns.regplot(
    data=df,
    x="Teknik Beceri Sayısı",
    y="Başvuran Sayısı",
    scatter_kws={"alpha": 0.7},
    line_kws={"color": "red"}
)
plt.title("Teknik Beceri Sayısı ve Başvuran Sayısı İlişkisi")
plt.xlabel("Teknik Beceri Sayısı")
plt.ylabel("Başvuran Sayısı")
plt.tight_layout()
plt.savefig(cikti_klasoru / "beceri_ve_basvuru_iliskisi.png", dpi=150)
plt.close()

# En çok istenen teknik beceriler
beceriler = (
    df["Teknik Beceriler"]
    .dropna()
    .str.split(",")
    .explode()
    .str.strip()
)

en_cok_istenen_beceriler = beceriler.value_counts().head(10)

plt.figure()
sns.barplot(
    x=en_cok_istenen_beceriler.values,
    y=en_cok_istenen_beceriler.index,
    color="seagreen"
)
plt.title("En Çok Talep Edilen 10 Teknik Beceri")
plt.xlabel("İlan Sayısı")
plt.ylabel("Teknik Beceri")
plt.tight_layout()
plt.savefig(cikti_klasoru / "en_cok_istenen_beceriler.png", dpi=150)
plt.close()

# Sayısal ilişkiyi yazdır
korelasyon = df["Teknik Beceri Sayısı"].corr(df["Başvuran Sayısı"])
print(f"\nTeknik beceri sayısı – başvuran sayısı korelasyonu: {korelasyon:.2f}")
print("\nEDA grafikleri '04_Python/ciktilar' klasörüne kaydedildi.")


# 7) Şehir temizleme ve segment analizi

# Aynı şehrin farklı yazımlarını tek ad altında topluyoruz
df["Şehir Temiz"] = (
    df["Şehir"]
    .str.replace(", Türkiye", "", regex=False)
    .str.replace("Greater Van", "Van", regex=False)
    .str.strip()
)

# Yeni mezun uygunluğunu standartlaştır
df["Yeni Mezun"] = (
    df["Yeni Mezuna Uygun mu?"]
    .str.strip()
    .str.lower()
    .map({"evet": "Evet", "hayır": "Hayır"})
    .fillna("Belirsiz")
)

# Deneyim seviyesine göre ilan, ortalama başvuru ve ortalama beceri sayısı
deneyim_analizi = (
    df.groupby("Deneyim Seviyesi")
    .agg(
        ilan_sayisi=("Pozisyon", "size"),
        ortalama_basvuru=("Başvuran Sayısı", "mean"),
        ortalama_beceri=("Teknik Beceri Sayısı", "mean")
    )
    .sort_values("ortalama_basvuru", ascending=False)
    .round(2)
)

deneyim_analizi.to_csv(
    cikti_klasoru / "deneyim_seviyesi_analizi.csv",
    encoding="utf-8-sig"
)

print("\n--- DENEYİM SEVİYESİ ANALİZİ ---")
print(deneyim_analizi)

# Yeni mezun uygunluğuna göre analiz
yeni_mezun_analizi = (
    df.groupby("Yeni Mezun")
    .agg(
        ilan_sayisi=("Pozisyon", "size"),
        ortalama_basvuru=("Başvuran Sayısı", "mean"),
        ortalama_beceri=("Teknik Beceri Sayısı", "mean")
    )
    .sort_values("ilan_sayisi", ascending=False)
    .round(2)
)

yeni_mezun_analizi.to_csv(
    cikti_klasoru / "yeni_mezun_analizi.csv",
    encoding="utf-8-sig"
)

print("\n--- YENİ MEZUN ANALİZİ ---")
print(yeni_mezun_analizi)

# Çalışma şekline göre analiz
calisma_analizi = (
    df.groupby("Çalışma Şekli")
    .agg(
        ilan_sayisi=("Pozisyon", "size"),
        ortalama_basvuru=("Başvuran Sayısı", "mean")
    )
    .sort_values("ilan_sayisi", ascending=False)
    .round(2)
)

calisma_analizi.to_csv(
    cikti_klasoru / "calisma_sekli_analizi.csv",
    encoding="utf-8-sig"
)

print("\n--- ÇALIŞMA ŞEKLİ ANALİZİ ---")
print(calisma_analizi)

# Temizlenmiş şehir grafiği
plt.figure()
sehir_temiz_sayilari = df["Şehir Temiz"].value_counts().head(10)
sns.barplot(
    x=sehir_temiz_sayilari.values,
    y=sehir_temiz_sayilari.index,
    color="teal"
)
plt.title("Temizlenmiş Şehir Bilgisine Göre İlan Sayısı")
plt.xlabel("İlan Sayısı")
plt.ylabel("Şehir")
plt.tight_layout()
plt.savefig(cikti_klasoru / "temizlenmis_sehir_ilanlari.png", dpi=150)
plt.close()

# Deneyim seviyesine göre ortalama başvuru grafiği
plt.figure()
sns.barplot(
    x=deneyim_analizi.index,
    y=deneyim_analizi["ortalama_basvuru"],
    color="darkorange"
)
plt.title("Deneyim Seviyesine Göre Ortalama Başvuru Sayısı")
plt.xlabel("Deneyim Seviyesi")
plt.ylabel("Ortalama Başvuru Sayısı")
plt.xticks(rotation=20)
plt.tight_layout()
plt.savefig(cikti_klasoru / "deneyime_gore_ortalama_basvuru.png", dpi=150)
plt.close()

# Çalışma şekillerinin dağılımı
plt.figure()
calisma_sayilari = df["Çalışma Şekli"].value_counts()
sns.barplot(
    x=calisma_sayilari.index,
    y=calisma_sayilari.values,
    color="mediumpurple"
)
plt.title("Çalışma Şekline Göre İlan Dağılımı")
plt.xlabel("Çalışma Şekli")
plt.ylabel("İlan Sayısı")
plt.xticks(rotation=20)
plt.tight_layout()
plt.savefig(cikti_klasoru / "calisma_sekli_dagilimi.png", dpi=150)
plt.close()

print("\nSegment analizleri tamamlandı.")

# 8) Analiz bulgularını otomatik rapora dönüştürme

toplam_ilan = len(df)
istanbul_sayisi = (df["Şehir Temiz"] == "İstanbul").sum()
istanbul_orani = (istanbul_sayisi / toplam_ilan) * 100

en_yaygin_beceri = en_cok_istenen_beceriler.index[0]
en_yaygin_beceri_sayisi = en_cok_istenen_beceriler.iloc[0]

en_yuksek_basvuru_deneyim = deneyim_analizi["ortalama_basvuru"].idxmax()
en_yuksek_basvuru_degeri = deneyim_analizi.loc[
    en_yuksek_basvuru_deneyim, "ortalama_basvuru"
]

en_yaygin_calisma = calisma_analizi.index[0]
en_yaygin_calisma_sayisi = calisma_analizi.iloc[0]["ilan_sayisi"]

rapor = f"""# Türkiye İş İlanları — Python Veri Analizi Raporu

## Veri Seti Özeti

- Toplam ilan sayısı: {toplam_ilan}
- Toplam kategori sayısı: {df["Kategori"].nunique()}
- Toplam şehir sayısı: {df["Şehir Temiz"].nunique()}
- Tekrar eden kayıt sayısı: {tekrar_sayisi}
- Tamamen eksik alan: Maaş

## Veri Kalitesi Notları

- Maaş sütunundaki tüm kayıtlar eksik olduğu için maaş analizi yapılamamıştır.
- Şehir adlarındaki farklı yazımlar standartlaştırılmıştır.
- Kategoriler eşit sayıda ilan içerdiği için kategori bazında talep üstünlüğü yorumu yapılmamalıdır.
- Başvuran Sayısı alanındaki yüksek yoğunluklar, veri toplama kaynağındaki görünürlük veya sınırlandırma biçiminden etkilenmiş olabilir.

## Konum Analizi

- İstanbul'daki ilan sayısı: {istanbul_sayisi}
- İstanbul'un toplam ilanlardaki payı: %{istanbul_orani:.1f}
- Sonuç: Veri setindeki ilan fırsatları İstanbul'da belirgin biçimde yoğunlaşmaktadır.

## Teknik Beceri Analizi

- En çok talep edilen teknik beceri: {en_yaygin_beceri}
- Bu beceriyi isteyen ilan sayısı: {en_yaygin_beceri_sayisi}
- Öne çıkan diğer beceriler: SQL, Excel, Power BI, Git ve Python.
- Teknik beceri sayısı ile başvuran sayısı korelasyonu: {korelasyon:.2f}
- Sonuç: İki değişken arasında zayıf pozitif bir ilişki vardır. Daha fazla beceri şartı, tek başına daha fazla başvuru anlamına gelmez.

## Deneyim ve Çalışma Biçimi Analizi

- En yüksek ortalama başvuru alan deneyim seviyesi: {en_yuksek_basvuru_deneyim}
- Bu seviyedeki ortalama başvuru sayısı: {en_yuksek_basvuru_degeri:.2f}
- En yaygın çalışma şekli: {en_yaygin_calisma}
- Bu çalışma şeklindeki ilan sayısı: {en_yaygin_calisma_sayisi}

## Genel Sonuç

Bu veri setinde iş ilanları İstanbul'da yoğunlaşmaktadır. Teknik becerilerde SQL, Excel, Power BI ve Python gibi veri odaklı araçlar öne çıkmaktadır. Maaş verisinin tamamen eksik olması nedeniyle ücret karşılaştırması yapılamamıştır. Teknik beceri şartı arttıkça başvuru sayısı hafif artma eğilimindedir; ancak ilişki zayıftır ve başvuruları açıklamak için tek başına yeterli değildir.
"""

rapor_dosyasi = cikti_klasoru / "python_analiz_raporu.md"

with open(rapor_dosyasi, "w", encoding="utf-8") as dosya:
    dosya.write(rapor)

print(f"\nAnaliz raporu oluşturuldu: {rapor_dosyasi}")