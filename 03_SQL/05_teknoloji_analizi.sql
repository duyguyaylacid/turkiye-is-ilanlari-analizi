-- =========================================================
-- 05_TEKNOLOJI_ANALIZI.SQL
-- =========================================================


-- 1. SQL isteyen ilanlar

SELECT
    COUNT(*) AS sql_ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM turkiye_is_ilanlari),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%SQL%';



-- 2. Python isteyen ilanlar

SELECT
    COUNT(*) AS python_ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM turkiye_is_ilanlari),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Python%';



-- 3. Excel isteyen ilanlar

SELECT
    COUNT(*) AS excel_ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM turkiye_is_ilanlari),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Excel%';



-- 4. Power BI isteyen ilanlar

SELECT
    COUNT(*) AS powerbi_ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM turkiye_is_ilanlari),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Power BI%'
   OR aciklama ILIKE '%PowerBI%';



-- 5. Tableau isteyen ilanlar

SELECT
    COUNT(*) AS tableau_ilan_sayisi
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Tableau%';



-- 6. C# isteyen ilanlar

SELECT
    COUNT(*) AS csharp_ilan_sayisi
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%C#%';



-- 7. Java isteyen ilanlar

SELECT
    COUNT(*) AS java_ilan_sayisi
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Java%';



-- 8. .NET isteyen ilanlar

SELECT
    COUNT(*) AS dotnet_ilan_sayisi
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%.NET%'
   OR aciklama ILIKE '%dotnet%';



-- 9. R isteyen ilanlar

SELECT
    COUNT(*) AS r_ilan_sayisi
FROM turkiye_is_ilanlari
WHERE aciklama ~* '(^|[^a-zA-Z])R([^a-zA-Z]|$)';



-- 10. Teknoloji bazında özet

SELECT
    'SQL' AS teknoloji,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%SQL%'

UNION ALL

SELECT
    'Python',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Python%'

UNION ALL

SELECT
    'Excel',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Excel%'

UNION ALL

SELECT
    'Power BI',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Power BI%'
   OR aciklama ILIKE '%PowerBI%'

UNION ALL

SELECT
    'Tableau',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Tableau%'

UNION ALL

SELECT
    'C#',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%C#%'

UNION ALL

SELECT
    'Java',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%Java%'

UNION ALL

SELECT
    '.NET',
    COUNT(*)
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%.NET%'
   OR aciklama ILIKE '%dotnet%'

ORDER BY ilan_sayisi DESC;



-- 11. Pozisyona göre SQL talebi

SELECT
    pozisyon,
    COUNT(*) AS toplam_ilan,
    COUNT(
        CASE
            WHEN aciklama ILIKE '%SQL%' THEN 1
        END
    ) AS sql_isteyen_ilan
FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY sql_isteyen_ilan DESC;



-- 12. Pozisyona göre Python talebi

SELECT
    pozisyon,
    COUNT(*) AS toplam_ilan,
    COUNT(
        CASE
            WHEN aciklama ILIKE '%Python%' THEN 1
        END
    ) AS python_isteyen_ilan
FROM turkiye_is_ilanlari
GROUP BY pozisyon
ORDER BY python_isteyen_ilan DESC;



-- 13. SQL + Python birlikte isteyen ilanlar

SELECT
    COUNT(*) AS sql_python_ilan
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%SQL%'
  AND aciklama ILIKE '%Python%';



-- 14. SQL + Excel birlikte isteyen ilanlar

SELECT
    COUNT(*) AS sql_excel_ilan
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%SQL%'
  AND aciklama ILIKE '%Excel%';



-- 15. SQL + Power BI birlikte isteyen ilanlar

SELECT
    COUNT(*) AS sql_powerbi_ilan
FROM turkiye_is_ilanlari
WHERE aciklama ILIKE '%SQL%'
  AND (
      aciklama ILIKE '%Power BI%'
      OR aciklama ILIKE '%PowerBI%'
  );