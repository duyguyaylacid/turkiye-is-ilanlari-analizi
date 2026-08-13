-- =========================================================
-- 08_ILERI_SQL_ANALIZ.SQL
-- =========================================================


-- 1. POZİSYONLARI İLAN SAYISINA GÖRE SIRALAMA
-- RANK() kullanımı

SELECT
    pozisyon,
    COUNT(*) AS ilan_sayisi,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS pozisyon_sirasi
FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY pozisyon_sirasi;



-- 2. ŞİRKETLERİ İLAN SAYISINA GÖRE SIRALAMA

SELECT
    sirket,
    COUNT(*) AS ilan_sayisi,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS sirket_sirasi
FROM turkiye_is_ilanlari
GROUP BY sirket
ORDER BY sirket_sirasi;



-- 3. HER POZİSYONDA EN ÇOK İLAN VEREN ŞİRKET
-- ROW_NUMBER() + CTE

WITH sirket_pozisyon AS (
    SELECT
        pozisyon,
        sirket,
        COUNT(*) AS ilan_sayisi
    FROM turkiye_is_ilanlari
    GROUP BY pozisyon, sirket
),

siralamali AS (
    SELECT
        pozisyon,
        sirket,
        ilan_sayisi,
        ROW_NUMBER() OVER (
            PARTITION BY pozisyon
            ORDER BY ilan_sayisi DESC
        ) AS sira
    FROM sirket_pozisyon
)

SELECT
    pozisyon,
    sirket,
    ilan_sayisi
FROM siralamali
WHERE sira = 1
ORDER BY pozisyon;



-- 4. HER ŞİRKETİN EN ÇOK ARADIĞI POZİSYON

WITH sirket_pozisyon AS (
    SELECT
        sirket,
        pozisyon,
        COUNT(*) AS ilan_sayisi
    FROM turkiye_is_ilanlari
    GROUP BY sirket, pozisyon
),

siralamali AS (
    SELECT
        sirket,
        pozisyon,
        ilan_sayisi,
        ROW_NUMBER() OVER (
            PARTITION BY sirket
            ORDER BY ilan_sayisi DESC
        ) AS sira
    FROM sirket_pozisyon
)

SELECT
    sirket,
    pozisyon,
    ilan_sayisi
FROM siralamali
WHERE sira = 1
ORDER BY ilan_sayisi DESC;



-- 5. POZİSYONLARIN TOPLAM İLAN İÇİNDEKİ PAYI

WITH pozisyonlar AS (
    SELECT
        pozisyon,
        COUNT(*) AS ilan_sayisi
    FROM turkiye_is_ilanlari
    GROUP BY pozisyon
)

SELECT
    pozisyon,
    ilan_sayisi,
    ROUND(
        ilan_sayisi * 100.0 /
        SUM(ilan_sayisi) OVER (),
        2
    ) AS pazar_payi_yuzde
FROM pozisyonlar
ORDER BY pazar_payi_yuzde DESC;



-- 6. YENİ MEZUNLAR İÇİN EN UYGUN POZİSYONLAR

WITH pozisyon_analiz AS (
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
        ) AS yeni_mezun_ilan

    FROM turkiye_is_ilanlari
    GROUP BY pozisyon
)

SELECT
    pozisyon,
    toplam_ilan,
    yeni_mezun_ilan,
    ROUND(
        yeni_mezun_ilan * 100.0 / toplam_ilan,
        2
    ) AS yeni_mezun_orani
FROM pozisyon_analiz
ORDER BY yeni_mezun_orani DESC;



-- 7. EN ÇOK BAŞVURU ALAN 10 İLAN

SELECT
    ROW_NUMBER() OVER (
        ORDER BY basvuran_sayisi DESC
    ) AS sira,
    sirket,
    pozisyon,
    basvuran_sayisi
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi IS NOT NULL
ORDER BY basvuran_sayisi DESC
LIMIT 10;



-- 8. ORTALAMA BAŞVURUNUN ÜZERİNDE BAŞVURU ALAN İLANLAR

SELECT
    sirket,
    pozisyon,
    basvuran_sayisi
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi >
      (
          SELECT AVG(basvuran_sayisi)
          FROM turkiye_is_ilanlari
          WHERE basvuran_sayisi IS NOT NULL
      )
ORDER BY basvuran_sayisi DESC;



-- 9. POZİSYON + ŞİRKET İLAN SAYISI
-- Ortalama şirket ilan sayısından fazla olanlar

WITH sirket_ilan AS (
    SELECT
        sirket,
        COUNT(*) AS ilan_sayisi
    FROM turkiye_is_ilanlari
    GROUP BY sirket
),

ortalama AS (
    SELECT AVG(ilan_sayisi) AS ortalama_ilan
    FROM sirket_ilan
)

SELECT
    s.sirket,
    s.ilan_sayisi
FROM sirket_ilan s
CROSS JOIN ortalama o
WHERE s.ilan_sayisi > o.ortalama_ilan
ORDER BY s.ilan_sayisi DESC;



-- 10. GENEL PROJE KPI TABLOSU

SELECT
    COUNT(*) AS toplam_ilan,

    COUNT(DISTINCT sirket) AS farkli_sirket,

    COUNT(DISTINCT pozisyon) AS farkli_pozisyon,

    COUNT(DISTINCT sehir) AS farkli_lokasyon,

    ROUND(AVG(basvuran_sayisi), 2) AS ortalama_basvuru,

    MAX(basvuran_sayisi) AS maksimum_basvuru

FROM turkiye_is_ilanlari;



-- 11. POZİSYONLARI BAŞVURU REKABETİNE GÖRE SIRALA

SELECT
    pozisyon,
    COUNT(*) AS ilan_sayisi,
    ROUND(AVG(basvuran_sayisi), 2) AS ortalama_basvuru,
    RANK() OVER (
        ORDER BY AVG(basvuran_sayisi) DESC
    ) AS rekabet_sirasi
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi IS NOT NULL
GROUP BY pozisyon
ORDER BY rekabet_sirasi;



-- 12. ŞİRKETLERİN TOPLAM İLAN İÇİNDEKİ PAYI

WITH sirketler AS (
    SELECT
        sirket,
        COUNT(*) AS ilan_sayisi
    FROM turkiye_is_ilanlari
    GROUP BY sirket
)

SELECT
    sirket,
    ilan_sayisi,
    ROUND(
        ilan_sayisi * 100.0 /
        SUM(ilan_sayisi) OVER (),
        2
    ) AS ilan_payi_yuzde
FROM sirketler
ORDER BY ilan_sayisi DESC;



-- 13. POZİSYON + ÇALIŞMA TİPİ YÜZDELERİ

SELECT
    pozisyon,
    calisma_tipi,
    COUNT(*) AS ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (
            PARTITION BY pozisyon
        ),
        2
    ) AS pozisyon_icindeki_oran
FROM turkiye_is_ilanlari
GROUP BY pozisyon, calisma_tipi
ORDER BY pozisyon, ilan_sayisi DESC;