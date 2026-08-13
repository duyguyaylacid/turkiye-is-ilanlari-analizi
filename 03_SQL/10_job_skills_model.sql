-- =========================================================
-- 10_JOB_SKILLS_MODEL.SQL
-- İlan - Teknoloji İlişkisel Veri Modeli
-- =========================================================


-- =========================================================
-- 1. TEKNOLOJİLER TABLOSU
-- =========================================================

CREATE TABLE IF NOT EXISTS teknolojiler (
    id SERIAL PRIMARY KEY,
    teknoloji_adi VARCHAR(100) NOT NULL UNIQUE
);


-- =========================================================
-- 2. İLAN - TEKNOLOJİ İLİŞKİ TABLOSU
-- =========================================================

CREATE TABLE IF NOT EXISTS ilan_teknolojileri (
    ilan_id INTEGER NOT NULL,
    teknoloji_id INTEGER NOT NULL,

    PRIMARY KEY (ilan_id, teknoloji_id),

    FOREIGN KEY (ilan_id)
        REFERENCES turkiye_is_ilanlari(id)
        ON DELETE CASCADE,

    FOREIGN KEY (teknoloji_id)
        REFERENCES teknolojiler(id)
        ON DELETE CASCADE
);


-- =========================================================
-- 3. TEKNOLOJİLERİ EKLE
-- =========================================================

INSERT INTO teknolojiler (teknoloji_adi)
VALUES
    ('SQL'),
    ('Python'),
    ('Excel'),
    ('Power BI'),
    ('Tableau'),
    ('C#'),
    ('Java'),
    ('.NET'),
    ('R'),
    ('JavaScript'),
    ('React'),
    ('C++'),
    ('Git'),
    ('Docker')
ON CONFLICT (teknoloji_adi) DO NOTHING;


-- =========================================================
-- 4. SQL
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'SQL'
  AND i.aciklama ILIKE '%SQL%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 5. PYTHON
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'Python'
  AND i.aciklama ILIKE '%Python%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 6. EXCEL
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'Excel'
  AND i.aciklama ILIKE '%Excel%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 7. POWER BI
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'Power BI'
  AND (
      i.aciklama ILIKE '%Power BI%'
      OR i.aciklama ILIKE '%PowerBI%'
  )
ON CONFLICT DO NOTHING;


-- =========================================================
-- 8. TABLEAU
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'Tableau'
  AND i.aciklama ILIKE '%Tableau%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 9. C#
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'C#'
  AND i.aciklama ILIKE '%C#%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 10. JAVA
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'Java'
  AND i.aciklama ILIKE '%Java%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 11. .NET
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = '.NET'
  AND (
      i.aciklama ILIKE '%.NET%'
      OR i.aciklama ILIKE '%dotnet%'
  )
ON CONFLICT DO NOTHING;


-- =========================================================
-- 12. R
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'R'
  AND i.aciklama ~* '(^|[^a-zA-Z])R([^a-zA-Z]|$)'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 13. JAVASCRIPT
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'JavaScript'
  AND i.aciklama ILIKE '%JavaScript%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 14. REACT
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'React'
  AND i.aciklama ILIKE '%React%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 15. C++
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'C++'
  AND i.aciklama ILIKE '%C++%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 16. GIT
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'Git'
  AND i.aciklama ILIKE '%Git%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 17. DOCKER
-- =========================================================

INSERT INTO ilan_teknolojileri (ilan_id, teknoloji_id)
SELECT i.id, t.id
FROM turkiye_is_ilanlari i
CROSS JOIN teknolojiler t
WHERE t.teknoloji_adi = 'Docker'
  AND i.aciklama ILIKE '%Docker%'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 18. KONTROL: TEKNOLOJİLER
-- =========================================================

SELECT *
FROM teknolojiler
ORDER BY id;


-- =========================================================
-- 19. KONTROL: İLAN-TEKNOLOJİ EŞLEŞMELERİ
-- =========================================================

SELECT
    it.ilan_id,
    t.teknoloji_adi
FROM ilan_teknolojileri it
JOIN teknolojiler t
    ON t.id = it.teknoloji_id
ORDER BY it.ilan_id, t.teknoloji_adi;


-- =========================================================
-- 20. TEKNOLOJİLERİN İLAN SAYILARI
-- =========================================================

SELECT
    t.teknoloji_adi,
    COUNT(it.ilan_id) AS ilan_sayisi
FROM teknolojiler t
LEFT JOIN ilan_teknolojileri it
    ON t.id = it.teknoloji_id
GROUP BY t.id, t.teknoloji_adi
ORDER BY ilan_sayisi DESC;


-- =========================================================
-- 21. HER İLANIN TEKNOLOJİLERİ
-- =========================================================

SELECT
    i.id AS ilan_id,
    i.pozisyon,
    i.sirket,
    STRING_AGG(
        t.teknoloji_adi,
        ', ' ORDER BY t.teknoloji_adi
    ) AS teknolojiler
FROM turkiye_is_ilanlari i
JOIN ilan_teknolojileri it
    ON i.id = it.ilan_id
JOIN teknolojiler t
    ON t.id = it.teknoloji_id
GROUP BY i.id, i.pozisyon, i.sirket
ORDER BY i.id;