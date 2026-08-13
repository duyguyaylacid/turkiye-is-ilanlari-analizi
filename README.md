# Türkiye İş İlanları Analizi

Türkiye’deki iş ilanlarını Excel, SQL, Power BI ve Python kullanarak analiz eden uçtan uca veri analizi projesi.

## Proje amacı

İş ilanlarındaki kategori, şehir, deneyim seviyesi, çalışma şekli, teknik beceriler ve başvuru yoğunluğunu incelemek; ardından temel bir makine öğrenmesi modeli ile ilan kategorisini tahmin etmektir.

## Kullanılan araçlar

- Excel — ham veri ve veri hazırlama
- PostgreSQL / SQL — veri tabanı işlemleri ve sorgular
- Power BI — dashboard ve görselleştirme
- Python — veri temizleme, keşifsel veri analizi ve makine öğrenmesi
- Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn

## Klasör yapısı

```text
Turkiye_Is_Ilanlari_Analizi
├── 01_Ham_Veriler          # İlk toplanan veri
├── 02_Temiz_Veriler        # Temizlenmiş Excel verisi
├── 03_SQL                  # SQL sorguları ve veritabanı işlemleri
├── 04_Python               # Python analiz ve makine öğrenmesi kodları
├── 05_PowerBI              # Power BI dosyaları
├── 06_Raporlar             # İsteğe bağlı PDF/Word raporları
├── 07_Ekran_Goruntuleri    # Proje ekran görüntüleri
├── 08_Dokumantasyon        # Proje dokümantasyonu
└── 09_Ciktilar
    ├── Python_Analizi      # Grafikler, CSV analizleri ve EDA raporu
    └── Makine_Ogrenmesi    # Model değerlendirme çıktıları
```

## Python analizi

`04_Python/veri_analizi.py` şu işlemleri yapar:

- Excel verisini okur.
- Eksik değerleri ve tekrar eden kayıtları kontrol eder.
- Şehir isimlerini standartlaştırır.
- Kategori, şehir, deneyim, çalışma şekli ve teknik beceri analizleri üretir.
- Grafik ve CSV çıktılarını `09_Ciktilar/Python_Analizi` klasörüne kaydeder.
- Analiz bulgularını `python_analiz_raporu.md` dosyasına yazar.

Çalıştırma:

```powershell
python 04_Python/veri_analizi.py
```

## Makine öğrenmesi

`04_Python/makine_ogrenmesi.py`, ilan özelliklerini kullanarak ilan kategorisini tahmin eder.

Modelde kullanılan bilgiler:

- Şehir
- Çalışma tipi
- Deneyim seviyesi
- Çalışma şekli
- Başvuran sayısı
- Teknik beceri sayısı

Model: Logistic Regression

Sonuç: Test verisinde %60 doğruluk oranı elde edilmiştir. Veri seti yalnızca 80 ilandan oluştuğu için sonuç eğitim amaçlı değerlendirilmelidir.

Çalıştırma:

```powershell
python 04_Python/makine_ogrenmesi.py
```

## Temel bulgular

- Veri setinde toplam 80 ilan bulunmaktadır.
- İlanlar İstanbul’da belirgin biçimde yoğunlaşmaktadır.
- Öne çıkan beceriler: R, SQL, Excel, Power BI, Git ve Python.
- Teknik beceri sayısı ile başvuran sayısı arasındaki korelasyon 0.21’dir; ilişki zayıf pozitiftir.
- Maaş sütunundaki tüm değerler eksik olduğu için ücret analizi yapılamamıştır.

## Kurulum

```powershell
python -m pip install -r 04_Python/requirements.txt
```

## Streamlit interaktif uygulaması

Bu projede analiz sonuçlarını tarayıcıdan filtreleyerek incelemek için Streamlit ile bir web uygulaması geliştirilmiştir.

Uygulamada şunlar bulunur:

- Kategori, şehir ve deneyim seviyesi filtreleri
- Toplam ilan sayısı, ortalama başvuru sayısı ve ortalama teknik beceri metrikleri
- Kategori ve şehir bazlı ilan grafikleri
- En çok talep edilen teknik beceriler grafiği
- Filtrelenmiş iş ilanları tablosu
- Makine öğrenmesi model sonucunun özeti

Uygulamayı çalıştırmak için:

```powershell
streamlit run 04_Python/streamlit_app.py