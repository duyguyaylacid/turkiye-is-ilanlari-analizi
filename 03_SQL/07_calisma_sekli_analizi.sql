-- =========================================================
-- 07_CALISMA_SEKLI_ANALIZI.SQL
-- =========================================================


-- 1. Genel çalışma tipi dağılımı

SELECT
    calisma_tipi,
    COUNT(*) AS ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
GROUP BY calisma_tipi
ORDER BY ilan_sayisi DESC;



-- 2. Pozisyon + çalışma tipi

SELECT
    pozisyon,
    calisma_tipi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, calisma_tipi
ORDER BY pozisyon, ilan_sayisi DESC;



-- 3. Pozisyonların remote ilan oranı

SELECT
    pozisyon,
    COUNT(*) AS toplam_ilan,

    COUNT(
        CASE
            WHEN calisma_tipi ILIKE '%remote%'
              OR calisma_tipi ILIKE '%uzaktan%'
            THEN 1
        END
    ) AS remote_ilan,

    ROUND(
        COUNT(
            CASE
                WHEN calisma_tipi ILIKE '%remote%'
                  OR calisma_tipi ILIKE '%uzaktan%'
                THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS remote_orani

FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY remote_orani DESC;



-- 4. Pozisyonların hibrit ilan oranı

SELECT
    pozisyon,
    COUNT(*) AS toplam_ilan,

    COUNT(
        CASE
            WHEN calisma_tipi ILIKE '%hibrit%'
              OR calisma_tipi ILIKE '%hybrid%'
            THEN 1
        END
    ) AS hibrit_ilan,

    ROUND(
        COUNT(
            CASE
                WHEN calisma_tipi ILIKE '%hibrit%'
                  OR calisma_tipi ILIKE '%hybrid%'
                THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS hibrit_orani

FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY hibrit_orani DESC;



-- 5. Yeni mezun + çalışma tipi

SELECT
    calisma_tipi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
WHERE deneyim_seviyesi ILIKE '%entry%'
   OR deneyim_seviyesi ILIKE '%junior%'
   OR deneyim_seviyesi ILIKE '%yeni mezun%'
GROUP BY calisma_tipi
ORDER BY ilan_sayisi DESC;



-- 6. Şehir + çalışma tipi

SELECT
    sehir,
    calisma_tipi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sehir, calisma_tipi
ORDER BY ilan_sayisi DESC;



-- 7. Remote ilanların pozisyon dağılımı

SELECT
    pozisyon,
    COUNT(*) AS remote_ilan
FROM turkiye_is_ilanlari
WHERE calisma_tipi ILIKE '%remote%'
   OR calisma_tipi ILIKE '%uzaktan%'
GROUP BY pozisyon
ORDER BY remote_ilan DESC;



-- 8. En çok remote ilan veren şirketler

SELECT
    sirket,
    COUNT(*) AS remote_ilan
FROM turkiye_is_ilanlari
WHERE calisma_tipi ILIKE '%remote%'
   OR calisma_tipi ILIKE '%uzaktan%'
GROUP BY sirket
ORDER BY remote_ilan DESC;



-- 9. Çalışma tipi + deneyim

SELECT
    calisma_tipi,
    deneyim_seviyesi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY calisma_tipi, deneyim_seviyesi
ORDER BY calisma_tipi, ilan_sayisi DESC;