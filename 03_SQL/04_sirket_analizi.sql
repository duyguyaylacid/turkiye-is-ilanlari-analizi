-- =========================================================
-- 04_SIRKET_ANALIZI.SQL
-- =========================================================


-- 1. En çok ilan yayınlayan şirketler

SELECT
    sirket,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket
ORDER BY ilan_sayisi DESC;



-- 2. En az 2 ilan yayınlayan şirketler

SELECT
    sirket,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket
HAVING COUNT(*) >= 2
ORDER BY ilan_sayisi DESC;



-- 3. Şirketlerin aradığı pozisyonlar

SELECT
    sirket,
    pozisyon,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket, pozisyon
ORDER BY sirket, ilan_sayisi DESC;



-- 4. Şirket başına farklı pozisyon sayısı

SELECT
    sirket,
    COUNT(DISTINCT pozisyon) AS farkli_pozisyon,
    COUNT(*) AS toplam_ilan
FROM turkiye_is_ilanlari
GROUP BY sirket
ORDER BY toplam_ilan DESC;



-- 5. Şirketlerin çalışma tipi dağılımı

SELECT
    sirket,
    calisma_tipi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket, calisma_tipi
ORDER BY sirket, ilan_sayisi DESC;



-- 6. Şirketlerin deneyim seviyesi dağılımı

SELECT
    sirket,
    deneyim_seviyesi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket, deneyim_seviyesi
ORDER BY sirket, ilan_sayisi DESC;



-- 7. En çok başvuru alan şirketler

SELECT
    sirket,
    COUNT(basvuran_sayisi) AS ilan_sayisi,
    ROUND(AVG(basvuran_sayisi), 2) AS ortalama_basvuru,
    MAX(basvuran_sayisi) AS maksimum_basvuru
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi IS NOT NULL
GROUP BY sirket
ORDER BY ortalama_basvuru DESC;



-- 8. Yeni mezunlara en çok ilan açan şirketler

SELECT
    sirket,
    COUNT(*) AS yeni_mezun_ilan
FROM turkiye_is_ilanlari
WHERE deneyim_seviyesi ILIKE '%entry%'
   OR deneyim_seviyesi ILIKE '%junior%'
   OR deneyim_seviyesi ILIKE '%yeni mezun%'
GROUP BY sirket
ORDER BY yeni_mezun_ilan DESC;



-- 9. Şirketlerin farklı şehirlerdeki ilan sayısı

SELECT
    sirket,
    COUNT(DISTINCT sehir) AS farkli_sehir_sayisi,
    COUNT(*) AS toplam_ilan
FROM turkiye_is_ilanlari
GROUP BY sirket
ORDER BY farkli_sehir_sayisi DESC;



-- 10. En aktif şirketler
-- En az 2 ilanı olan şirketleri göster

SELECT
    sirket,
    COUNT(*) AS ilan_sayisi,
    COUNT(DISTINCT pozisyon) AS pozisyon_sayisi,
    COUNT(DISTINCT sehir) AS sehir_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket
HAVING COUNT(*) >= 2
ORDER BY ilan_sayisi DESC;