-- =========================================================
-- 06_DENEYIM_ANALIZI.SQL
-- =========================================================


-- 1. Genel deneyim dağılımı

SELECT
    deneyim_seviyesi,
    COUNT(*) AS ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
GROUP BY deneyim_seviyesi
ORDER BY ilan_sayisi DESC;



-- 2. Yeni mezun / entry-level ilanlar

SELECT
    COUNT(*) AS yeni_mezun_ilan
FROM turkiye_is_ilanlari
WHERE deneyim_seviyesi ILIKE '%entry%'
   OR deneyim_seviyesi ILIKE '%junior%'
   OR deneyim_seviyesi ILIKE '%yeni mezun%';



-- 3. Yeni mezun ilanlarının toplam içindeki oranı

SELECT
    COUNT(*) AS yeni_mezun_ilan,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM turkiye_is_ilanlari),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
WHERE deneyim_seviyesi ILIKE '%entry%'
   OR deneyim_seviyesi ILIKE '%junior%'
   OR deneyim_seviyesi ILIKE '%yeni mezun%';



-- 4. Pozisyon bazında deneyim dağılımı

SELECT
    pozisyon,
    deneyim_seviyesi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, deneyim_seviyesi
ORDER BY pozisyon, ilan_sayisi DESC;



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



-- 6. Şirketlerin yeni mezun ilanları

SELECT
    sirket,
    COUNT(*) AS yeni_mezun_ilan
FROM turkiye_is_ilanlari
WHERE deneyim_seviyesi ILIKE '%entry%'
   OR deneyim_seviyesi ILIKE '%junior%'
   OR deneyim_seviyesi ILIKE '%yeni mezun%'
GROUP BY sirket
ORDER BY yeni_mezun_ilan DESC;



-- 7. Yeni mezun ilanlarında çalışma tipi

SELECT
    calisma_tipi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
WHERE deneyim_seviyesi ILIKE '%entry%'
   OR deneyim_seviyesi ILIKE '%junior%'
   OR deneyim_seviyesi ILIKE '%yeni mezun%'
GROUP BY calisma_tipi
ORDER BY ilan_sayisi DESC;



-- 8. Yeni mezun ilanlarında en çok aranan teknolojiler

SELECT
    'SQL' AS teknoloji,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
WHERE (
    deneyim_seviyesi ILIKE '%entry%'
    OR deneyim_seviyesi ILIKE '%junior%'
    OR deneyim_seviyesi ILIKE '%yeni mezun%'
)
AND aciklama ILIKE '%SQL%'

UNION ALL

SELECT
    'Python',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE (
    deneyim_seviyesi ILIKE '%entry%'
    OR deneyim_seviyesi ILIKE '%junior%'
    OR deneyim_seviyesi ILIKE '%yeni mezun%'
)
AND aciklama ILIKE '%Python%'

UNION ALL

SELECT
    'Excel',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE (
    deneyim_seviyesi ILIKE '%entry%'
    OR deneyim_seviyesi ILIKE '%junior%'
    OR deneyim_seviyesi ILIKE '%yeni mezun%'
)
AND aciklama ILIKE '%Excel%'

UNION ALL

SELECT
    'Power BI',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE (
    deneyim_seviyesi ILIKE '%entry%'
    OR deneyim_seviyesi ILIKE '%junior%'
    OR deneyim_seviyesi ILIKE '%yeni mezun%'
)
AND (
    aciklama ILIKE '%Power BI%'
    OR aciklama ILIKE '%PowerBI%'
)

ORDER BY ilan_sayisi DESC;