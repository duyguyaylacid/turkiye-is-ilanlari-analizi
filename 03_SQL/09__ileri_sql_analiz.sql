-- =========================================================
-- 09_MAAS_ANALIZI.SQL
-- =========================================================

-- 1. Maaş bilgisi olan ilan sayısı

SELECT
    COUNT(*) AS maas_dolu
FROM turkiye_is_ilanlari
WHERE maas IS NOT NULL
  AND TRIM(maas) <> '';



-- 2. Maaş bilgisi olmayan ilan sayısı

SELECT
    COUNT(*) AS maas_bos
FROM turkiye_is_ilanlari
WHERE maas IS NULL
   OR TRIM(maas) = '';



-- 3. Maaş bilgisi bulunma oranı

SELECT
    COUNT(*) AS toplam_ilan,

    COUNT(
        CASE
            WHEN maas IS NOT NULL
             AND TRIM(maas) <> ''
            THEN 1
        END
    ) AS maas_bilgisi_olan,

    ROUND(
        COUNT(
            CASE
                WHEN maas IS NOT NULL
                 AND TRIM(maas) <> ''
                THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS maas_bilgisi_orani
FROM turkiye_is_ilanlari;