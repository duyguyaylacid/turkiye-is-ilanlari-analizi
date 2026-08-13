from pathlib import Path

import pandas as pd
import streamlit as st
import matplotlib.pyplot as plt
import seaborn as sns

st.set_page_config(
    page_title="Türkiye İş İlanları Analizi",
    page_icon="📊",
    layout="wide"
)

PROJE_KLASORU = Path(__file__).resolve().parent.parent
VERI_DOSYASI = PROJE_KLASORU / "02_Temiz_Veriler" / "is_ilanlari_temiz.xlsx"

df = pd.read_excel(VERI_DOSYASI)

# Şehir adlarını standartlaştır
df["Şehir Temiz"] = (
    df["Şehir"]
    .str.replace(", Türkiye", "", regex=False)
    .str.replace("Greater Van", "Van", regex=False)
    .str.strip()
)

st.title("📊 Türkiye İş İlanları Analizi")
st.write("Excel, SQL, Power BI, Python ve makine öğrenmesi ile hazırlanmış interaktif analiz uygulaması.")

# Sol filtre paneli
st.sidebar.header("Filtreler")

kategoriler = st.sidebar.multiselect(
    "Kategori seç",
    options=sorted(df["Kategori"].unique()),
    default=sorted(df["Kategori"].unique())
)

sehirler = st.sidebar.multiselect(
    "Şehir seç",
    options=sorted(df["Şehir Temiz"].unique()),
    default=sorted(df["Şehir Temiz"].unique())
)

deneyimler = st.sidebar.multiselect(
    "Deneyim seviyesi seç",
    options=sorted(df["Deneyim Seviyesi"].unique()),
    default=sorted(df["Deneyim Seviyesi"].unique())
)

filtreli_df = df[
    (df["Kategori"].isin(kategoriler))
    & (df["Şehir Temiz"].isin(sehirler))
    & (df["Deneyim Seviyesi"].isin(deneyimler))
]

# Özet metrikleri
toplam_ilan = len(filtreli_df)
ortalama_basvuru = filtreli_df["Başvuran Sayısı"].mean()
ortalama_beceri = filtreli_df["Teknik Beceri Sayısı"].mean()

sutun1, sutun2, sutun3 = st.columns(3)
sutun1.metric("Toplam İlan", toplam_ilan)
sutun2.metric("Ortalama Başvuru", f"{ortalama_basvuru:.1f}" if toplam_ilan else "—")
sutun3.metric("Ortalama Teknik Beceri", f"{ortalama_beceri:.1f}" if toplam_ilan else "—")

if filtreli_df.empty:
    st.warning("Seçilen filtrelere uygun ilan bulunamadı.")
    st.stop()

st.divider()

# Kategori grafiği
sol, sag = st.columns(2)

with sol:
    st.subheader("Kategoriye Göre İlan Sayısı")
    kategori_sayilari = filtreli_df["Kategori"].value_counts()

    fig, ax = plt.subplots()
    sns.barplot(
        x=kategori_sayilari.values,
        y=kategori_sayilari.index,
        color="steelblue",
        ax=ax
    )
    ax.set_xlabel("İlan Sayısı")
    ax.set_ylabel("Kategori")
    st.pyplot(fig)

with sag:
    st.subheader("Şehre Göre İlan Sayısı")
    sehir_sayilari = filtreli_df["Şehir Temiz"].value_counts().head(10)

    fig, ax = plt.subplots()
    sns.barplot(
        x=sehir_sayilari.values,
        y=sehir_sayilari.index,
        color="teal",
        ax=ax
    )
    ax.set_xlabel("İlan Sayısı")
    ax.set_ylabel("Şehir")
    st.pyplot(fig)

# Beceri grafiği
st.subheader("En Çok Talep Edilen Teknik Beceriler")

beceriler = (
    filtreli_df["Teknik Beceriler"]
    .dropna()
    .str.split(",")
    .explode()
    .str.strip()
)

en_cok_istenen = beceriler.value_counts().head(10)

fig, ax = plt.subplots(figsize=(10, 5))
sns.barplot(
    x=en_cok_istenen.values,
    y=en_cok_istenen.index,
    color="seagreen",
    ax=ax
)
ax.set_xlabel("İlan Sayısı")
ax.set_ylabel("Teknik Beceri")
st.pyplot(fig)

# İlan tablosu
st.subheader("Filtrelenmiş İlanlar")

gosterilecek_sutunlar = [
    "Kategori",
    "Pozisyon",
    "Şirket",
    "Şehir Temiz",
    "Deneyim Seviyesi",
    "Çalışma Şekli",
    "Başvuran Sayısı",
    "Teknik Beceriler",
]

st.dataframe(
    filtreli_df[gosterilecek_sutunlar],
    use_container_width=True,
    hide_index=True
)

# ML sonucu
st.divider()
st.subheader("Makine Öğrenmesi Notu")
st.info(
    "Logistic Regression modeli ilan kategorisini tahmin etmek için kullanıldı. "
    "Test verisinde %60 doğruluk elde edildi. Veri seti 80 ilandan oluştuğu için "
    "bu sonuç eğitim amaçlı değerlendirilmelidir."
)