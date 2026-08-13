# Proje Dokümantasyonu

## 1. Veri kaynağı ve yapı

Projede Türkiye iş ilanlarına ait 80 kayıttan oluşan bir veri seti kullanılmıştır. Veri setinde kategori, pozisyon, şirket, şehir, ilan tarihi, çalışma tipi, deneyim seviyesi, teknik beceriler ve başvuran sayısı gibi alanlar bulunmaktadır.

## 2. Veri temizleme

Veri analizinden önce eksik değerler, tekrar eden kayıtlar ve metin biçimindeki farklılıklar incelenmiştir.

- Tekrar eden kayıt sayısı: 0
- Maaş alanı: Tüm kayıtlarda eksik
- Şehir alanı: Farklı yazımlar mümkün olduğunca standartlaştırılmıştır.

Maaş alanı tamamen boş olduğu için maaş karşılaştırması yapılmamıştır. Bu durum analiz raporunda veri kısıtı olarak belirtilmiştir.

## 3. Keşifsel veri analizi

Python ile aşağıdaki analizler yapılmıştır:

- Kategoriye göre ilan sayısı
- Şehre göre ilan yoğunluğu
- Deneyim seviyesine göre ilanlar
- Çalışma şekline göre ilan dağılımı
- En çok talep edilen teknik beceriler
- Teknik beceri sayısı ile başvuran sayısı ilişkisi
- Yeni mezun uygunluğu analizi

## 4. Bulgular

Kategoriler veri setinde eşit sayıda ilan içerdiğinden, kategoriler arasında talep karşılaştırması yapılmamıştır.

İlanların büyük bölümü İstanbul’da yer almaktadır. Ankara ve İzmir daha düşük ilan sayılarıyla takip etmektedir.

Teknik becerilerde R, SQL, Excel, Power BI, Git ve Python öne çıkmıştır. Ancak R becerisinin tüm ilanlarda bulunması, veri setinin oluşturulma biçiminden kaynaklanıyor olabilir; bu nedenle gerçek iş piyasası genellemesi olarak değerlendirilmemelidir.

Teknik beceri sayısı ile başvuran sayısı arasındaki korelasyon 0.21’dir. Bu, iki değişken arasında zayıf pozitif ilişki olduğunu gösterir.

## 5. Makine öğrenmesi

İlk olarak “Yeni Mezuna Uygun mu?” alanı tahmin hedefi olarak düşünülmüştür. Ancak sınıflar dengesizdir: yalnızca bir adet “Evet” kaydı vardır. Bu nedenle model eğitimi için uygun değildir.

Tahmin hedefi daha dengeli olan `Kategori` alanı olarak değiştirilmiştir. Her kategoride 20 kayıt bulunur.

Modelde Logistic Regression kullanılmıştır. Kategorik veriler One-Hot Encoding ile sayısallaştırılmış, sayısal veriler StandardScaler ile ölçeklenmiştir.

Veri seti eğitim ve test olarak ayrılmıştır:

- Eğitim verisi: %75
- Test verisi: %25
- Test kayıt sayısı: 20

Model %60 doğruluk elde etmiştir. Bu sonuç rastgele tahminden daha iyidir, ancak küçük veri seti nedeniyle sınırlı değerlendirilmelidir.

## 6. Sonuç

Bu proje; ham veriden temiz veriye, SQL analizinden Power BI görselleştirmesine, Python EDA çalışmalarından makine öğrenmesi modeline kadar uçtan uca bir veri analizi sürecini kapsamaktadır.


## 7. Streamlit ile interaktif analiz uygulaması

Projenin Python analizleri, Streamlit kullanılarak interaktif bir web uygulamasına dönüştürülmüştür.

Kullanıcı; kategori, şehir ve deneyim seviyesi filtrelerini kullanarak iş ilanlarını dinamik biçimde inceleyebilir. Uygulama, filtrelere göre toplam ilan sayısını, ortalama başvuru sayısını, ortalama teknik beceri sayısını ve ilgili grafikleri günceller.

Bu aşama, statik Python grafiklerini kullanıcıyla etkileşim kurulabilen bir analiz arayüzüne dönüştürmektedir.

Uygulamayı başlatmak için:

```powershell
streamlit run 04_Python/streamlit_app.py