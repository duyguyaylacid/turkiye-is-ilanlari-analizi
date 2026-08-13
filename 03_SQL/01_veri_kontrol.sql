-- 1. Toplam ilan sayısı
SELECT COUNT(*) AS toplam_ilan
FROM turkiye_is_ilanlari;


-- 2. İlk 10 kayıt
SELECT *
FROM turkiye_is_ilanlari
LIMIT 10;


-- 3. Pozisyon dağılımı
SELECT
    pozisyon,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY ilan_sayisi DESC;


-- 4. Şehir dağılımı
SELECT
    sehir,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sehir
ORDER BY ilan_sayisi DESC;


-- 5. Çalışma tipi dağılımı
SELECT
    calisma_tipi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY calisma_tipi
ORDER BY ilan_sayisi DESC;


-- 6. Deneyim seviyesi dağılımı
SELECT
    deneyim_seviyesi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY deneyim_seviyesi
ORDER BY ilan_sayisi DESC;


-- 7. Şirketlerin ilan sayıları
SELECT
    sirket,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket
ORDER BY ilan_sayisi DESC;


-- 8. Eksik veri kontrolü
SELECT
    COUNT(*) AS toplam_kayit,
    COUNT(pozisyon) AS pozisyon_dolu,
    COUNT(sirket) AS sirket_dolu,
    COUNT(sehir) AS sehir_dolu,
    COUNT(calisma_tipi) AS calisma_tipi_dolu,
    COUNT(deneyim_seviyesi) AS deneyim_dolu
FROM turkiye_is_ilanlari;