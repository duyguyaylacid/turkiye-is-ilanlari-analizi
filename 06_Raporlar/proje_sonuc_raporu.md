# Türkiye İş İlanları Analizi — Sonuç Raporu

## Proje özeti

Bu projede Türkiye iş ilanları Excel, SQL, Power BI ve Python kullanılarak analiz edilmiştir. Amaç; ilanların şehir, kategori, deneyim seviyesi, çalışma şekli, teknik beceri ve başvuru yoğunluğuna göre incelenmesidir.

## Veri seti

- Toplam ilan sayısı: 80
- İncelenen kategori sayısı: 4
- Maaş verisi: Tüm kayıtlarda eksik
- Tekrar eden kayıt: Bulunmadı

## Ana bulgular

- İlanların büyük bölümü İstanbul’da yoğunlaşmaktadır.
- SQL, Excel, Power BI ve Python öne çıkan teknik becerilerdir.
- Teknik beceri sayısı ile başvuran sayısı arasında 0.21 korelasyon vardır. Bu zayıf pozitif ilişkidir.
- Maaş alanı tamamen eksik olduğu için ücret karşılaştırması yapılamamıştır.
- Kategoriler eşit sayıda ilan içerdiğinden kategori bazında talep üstünlüğü çıkarılamamıştır.

## Makine öğrenmesi sonucu

İlan kategorisini tahmin etmek için Logistic Regression modeli kullanılmıştır.

- Eğitim verisi: 60 ilan
- Test verisi: 20 ilan
- Model doğruluğu: %60

Sonuç, rastgele tahminden daha iyidir; ancak veri seti küçük olduğu için model gerçek kullanım amacıyla değil, eğitim ve proje uygulaması olarak değerlendirilmelidir.

## Genel değerlendirme

Proje; veri toplama, temizleme, SQL analizi, görselleştirme, Python ile EDA ve makine öğrenmesi süreçlerini uçtan uca uygulamaktadır. Veri kalitesindeki maaş eksikliği ve küçük örneklem sayısı, sonuçların en önemli sınırlılıklarıdır.