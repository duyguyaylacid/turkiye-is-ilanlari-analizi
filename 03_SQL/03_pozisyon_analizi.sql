-- =========================================================
-- 03_POZISYON_ANALIZI.SQL
-- =========================================================


-- 1. Pozisyonların toplam ilan sayısı

SELECT
    pozisyon,
    COUNT(*) AS ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY ilan_sayisi DESC;



-- 2. Pozisyon + çalışma tipi

SELECT
    pozisyon,
    calisma_tipi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, calisma_tipi
ORDER BY pozisyon, ilan_sayisi DESC;



-- 3. Pozisyon + deneyim seviyesi

SELECT
    pozisyon,
    deneyim_seviyesi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, deneyim_seviyesi
ORDER BY pozisyon, ilan_sayisi DESC;



-- 4. Pozisyon bazında yeni mezun ilanları

SELECT
    pozisyon,
    COUNT(*) AS yeni_mezun_ilan_sayisi
FROM turkiye_is_ilanlari
WHERE deneyim_seviyesi ILIKE '%entry%'
   OR deneyim_seviyesi ILIKE '%junior%'
   OR deneyim_seviyesi ILIKE '%yeni mezun%'
GROUP BY pozisyon
ORDER BY yeni_mezun_ilan_sayisi DESC;



-- 5. Pozisyon bazında yeni mezun oranı

SELECT
    pozisyon,
    COUNT(*) AS toplam_ilan,

    COUNT(
        CASE
            WHEN deneyim_seviyesi ILIKE '%entry%'
              OR deneyim_seviyesi ILIKE '%junior%'
              OR deneyim_seviyesi ILIKE '%yeni mezun%'
            THEN 1
        END
    ) AS yeni_mezun_ilan,

    ROUND(
        COUNT(
            CASE
                WHEN deneyim_seviyesi ILIKE '%entry%'
                  OR deneyim_seviyesi ILIKE '%junior%'
                  OR deneyim_seviyesi ILIKE '%yeni mezun%'
                THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS yeni_mezun_orani

FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY yeni_mezun_orani DESC;



-- 6. Pozisyonların şehir dağılımı

SELECT
    pozisyon,
    sehir,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, sehir
ORDER BY pozisyon, ilan_sayisi DESC;



-- 7. Pozisyonların ortalama başvuru sayısı

SELECT
    pozisyon,
    COUNT(basvuran_sayisi) AS ilan_sayisi,
    ROUND(AVG(basvuran_sayisi), 2) AS ortalama_basvuru,
    MAX(basvuran_sayisi) AS maksimum_basvuru
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi IS NOT NULL
GROUP BY pozisyon
ORDER BY ortalama_basvuru DESC;



-- 8. Pozisyon bazında en çok başvuru alan ilan

SELECT
    pozisyon,
    sirket,
    basvuran_sayisi
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi IS NOT NULL
ORDER BY basvuran_sayisi DESC;



-- 9. Pozisyon + şirket

SELECT
    pozisyon,
    sirket,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, sirket
ORDER BY pozisyon, ilan_sayisi DESC;



-- 10. Pozisyon bazında farklı şirket sayısı

SELECT
    pozisyon,
    COUNT(DISTINCT sirket) AS sirket_sayisi,
    COUNT(*) AS toplam_ilan
FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY toplam_ilan DESC;