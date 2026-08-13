-- =========================================================
-- 02_GENEL_ANALIZ.SQL
-- =========================================================


-- 1. POZİSYON DAĞILIMI
-- Hangi pozisyon için kaç ilan var ve toplamın yüzde kaçı?

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


-- 2. ÇALIŞMA TİPİ DAĞILIMI
-- Uzaktan, hibrit ve ofis ilanlarının dağılımı

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


-- 3. DENEYİM SEVİYESİ DAĞILIMI

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


-- 4. YENİ MEZUNLARA UYGUN İLANLAR
-- Deneyim bilgisinde entry-level / junior / yeni mezun geçen ilanlar

SELECT
    COUNT(*) AS yeni_mezun_ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM turkiye_is_ilanlari),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
WHERE deneyim_seviyesi ILIKE '%entry%'
   OR deneyim_seviyesi ILIKE '%junior%'
   OR deneyim_seviyesi ILIKE '%yeni mezun%';



-- 5. POZİSYON BAZINDA YENİ MEZUN UYGUNLUĞU

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



-- 6. ŞEHİR DAĞILIMI (NORMALLEŞTİRİLMİŞ)

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




-- 7. POZİSYON + ÇALIŞMA TİPİ
-- Hangi pozisyonda hangi çalışma modeli daha yaygın?

SELECT
    pozisyon,
    calisma_tipi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, calisma_tipi
ORDER BY pozisyon, ilan_sayisi DESC;



-- 8. POZİSYON + DENEYİM
-- Pozisyonların hangi seviyede eleman aradığını gör

SELECT
    pozisyon,
    deneyim_seviyesi,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, deneyim_seviyesi
ORDER BY pozisyon, ilan_sayisi DESC;



-- 9. ŞİRKETLERİN İLAN SAYILARI
-- En çok ilan yayınlayan şirketler

SELECT
    sirket,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket
ORDER BY ilan_sayisi DESC;



-- 10. EN ÇOK BAŞVURU ALAN İLANLAR

SELECT
    sirket,
    pozisyon,
    sehir,
    basvuran_sayisi
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi IS NOT NULL
ORDER BY basvuran_sayisi DESC
LIMIT 10;


-- 11. ORTALAMA BAŞVURU SAYISI

SELECT
    ROUND(AVG(basvuran_sayisi), 2) AS ortalama_basvuru
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi IS NOT NULL;



-- 12. POZİSYONA GÖRE ORTALAMA BAŞVURU

SELECT
    pozisyon,
    COUNT(*) AS ilan_sayisi,
    ROUND(AVG(basvuran_sayisi), 2) AS ortalama_basvuru
FROM turkiye_is_ilanlari
WHERE basvuran_sayisi IS NOT NULL
GROUP BY pozisyon
ORDER BY ortalama_basvuru DESC;



-- 13. MAAŞ BİLGİSİ OLAN İLAN SAYISI

SELECT
    COUNT(*) AS maas_bilgisi_olan_ilan
FROM turkiye_is_ilanlari
WHERE maas IS NOT NULL;



-- 14. MAAŞ BİLGİSİ OLAN İLANLARIN ORANI

SELECT
    COUNT(*) AS maasli_ilan,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM turkiye_is_ilanlari),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
WHERE maas IS NOT NULL;



-- 15. MAAŞ İSTATİSTİKLERİ

SELECT
    ROUND(AVG(maas), 2) AS ortalama_maas,
    MIN(maas) AS minimum_maas,
    MAX(maas) AS maksimum_maas
FROM turkiye_is_ilanlari
WHERE maas IS NOT NULL;



-- 16. POZİSYONA GÖRE MAAŞ

SELECT
    pozisyon,
    COUNT(maas) AS maasli_ilan_sayisi,
    ROUND(AVG(maas), 2) AS ortalama_maas,
    MIN(maas) AS minimum_maas,
    MAX(maas) AS maksimum_maas
FROM turkiye_is_ilanlari
WHERE maas IS NOT NULL
GROUP BY pozisyon
ORDER BY ortalama_maas DESC;



-- 17. EN ÇOK ARANAN İLAN KATEGORİLERİ

SELECT
    kategori,
    COUNT(*) AS ilan_sayisi,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS oran_yuzde
FROM turkiye_is_ilanlari
GROUP BY kategori
ORDER BY ilan_sayisi DESC;



-- 18. POZİSYON + ŞEHİR
-- Hangi pozisyon hangi şehirlerde yoğunlaşıyor?

SELECT
    pozisyon,
    sehir,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY pozisyon, sehir
ORDER BY ilan_sayisi DESC;



-- 19. EN ÇOK İLAN VEREN ŞİRKETLER
-- En az 2 ilan yayınlayan şirketler

SELECT
    sirket,
    COUNT(*) AS ilan_sayisi
FROM turkiye_is_ilanlari
GROUP BY sirket
HAVING COUNT(*) >= 2
ORDER BY ilan_sayisi DESC;



-- 20. GENEL VERİ ÖZETİ
-- Projenin temel KPI'ları

SELECT
    COUNT(*) AS toplam_ilan,
    COUNT(DISTINCT sirket) AS farkli_sirket,
    COUNT(DISTINCT pozisyon) AS farkli_pozisyon,
    COUNT(DISTINCT sehir) AS farkli_sehir,
    COUNT(DISTINCT kategori) AS farkli_kategori
FROM turkiye_is_ilanlari;