CREATE TABLE ibd08.informe (
    f Date NOT NULL,
    h UInt8 NOT NULL,
    url String NOT NULL,
    di Nullable(UInt32),
    du Nullable(UInt32),
    au Nullable(UInt32)
) ENGINE = ReplacingMergeTree() ORDER BY (f, h, url);

INSERT INTO ibd08.informe
SELECT
    toDate(ts) AS f,
    toUInt8(toHour(ts)) AS h,
    url,
    ip OVER (PARTITION BY h, f) AS di, 
    url OVER (PARTITION BY h, f) AS du,
    COUNT(url) OVER (PARTITION BY f, h, url) AS au 
FROM ibd08.accesos
ORDER BY f, h, url;
