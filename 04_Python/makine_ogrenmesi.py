from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
from sklearn.preprocessing import OneHotEncoder, StandardScaler

# 1) Veriyi oku
PROJE_KLASORU = Path(__file__).resolve().parent.parent
VERI_DOSYASI = PROJE_KLASORU / "02_Temiz_Veriler" / "is_ilanlari_temiz.xlsx"

df = pd.read_excel(VERI_DOSYASI)

# 2) Tahmin hedefi: ilanın yeni mezuna uygunluğu
hedef = "Kategori"

# Modelde kullanılacak alanlar
kategorik_sutunlar = [
    "Şehir",
    "Çalışma Tipi",
    "Deneyim Seviyesi",
    "Çalışma Şekli",
]

sayisal_sutunlar = [
    "Başvuran Sayısı",
    "Teknik Beceri Sayısı",
]

X = df[kategorik_sutunlar + sayisal_sutunlar]
y = df[hedef].str.strip()

print("\n--- HEDEF DEĞİŞKEN DAĞILIMI ---")
print(y.value_counts())

# 3) Eğitim ve test verisini ayır
X_egitim, X_test, y_egitim, y_test = train_test_split(
    X,
    y,
    test_size=0.25,
    random_state=42,
    stratify=y
)

# 4) Kategorik alanları sayısallaştır
on_isleme = ColumnTransformer(
    transformers=[
        ("kategori", OneHotEncoder(handle_unknown="ignore"), kategorik_sutunlar),
        ("sayisal", StandardScaler(), sayisal_sutunlar),
    ]
)

# 5) Modeli kur ve eğit
model = Pipeline(
    steps=[
        ("on_isleme", on_isleme),
        ("siniflandirici", LogisticRegression(max_iter=5000, solver="lbfgs"))
    ]
)

model.fit(X_egitim, y_egitim)

# 6) Tahmin ve değerlendirme
tahminler = model.predict(X_test)
dogruluk = accuracy_score(y_test, tahminler)

print(f"\nModel doğruluk oranı: %{dogruluk * 100:.2f}")
print("\n--- SINIFLANDIRMA RAPORU ---")
print(classification_report(y_test, tahminler, zero_division=0))

# 7) Çıktıları kaydet
cikti_klasoru = PROJE_KLASORU / "09_Ciktilar" / "Makine_Ogrenmesi"
cikti_klasoru.mkdir(parents=True, exist_ok=True)

rapor = classification_report(y_test, tahminler, zero_division=0)

with open(cikti_klasoru / "model_degerlendirme.txt", "w", encoding="utf-8") as dosya:
    dosya.write(f"İlan kategorisi tahmin modeli doğruluk oranı: %{dogruluk * 100:.2f}\n\n")
    dosya.write(rapor)

# Karışıklık matrisi
matris = confusion_matrix(y_test, tahminler, labels=model.classes_)

plt.figure(figsize=(8, 6))
sns.heatmap(
    matris,
    annot=True,
    fmt="d",
    cmap="Blues",
    xticklabels=model.classes_,
    yticklabels=model.classes_
)
plt.title("İlan Kategorisi — Karışıklık Matrisi")
plt.xlabel("Model Tahmini")
plt.ylabel("Gerçek Değer")
plt.tight_layout()
plt.savefig(cikti_klasoru / "karisiklik_matrisi.png", dpi=150)
plt.close()

print(f"\nModel çıktıları kaydedildi: {cikti_klasoru}")