CREATE TABLE ibd08.hstats
(
    f Date NOT NULL, 
    h UInt8 NOT NULL, 
    urls AggregateFunction(uniq, String),
    ips AggregateFunction(uniq, IPv4),
    uaids AggregateFunction(uniq, String),
    tot AggregateFunction(count, UInt32)
) ENGINE = AggregatingMergeTree ORDER BY (f, h);

CREATE MATERIALIZED view ibd08.hstats_mv
TO ibd08.hstats
AS SELECT
	toDate(ts) AS f,
	toHour(ts) AS h,
	uniqState(url) AS urls,
	uniqState(ip) AS ips,
	uniqState(uaid) AS uaids,
	countState(h) AS tot
FROM ibd08.accesos
GROUP BY f, h


SELECT f, h, uniqMerge(urls) as url, uniqMerge(ips)as ips, uniqMerge(uaids) as uaids, countMerge(tot) as tot 
FROM ibd08.hstats
GROUP BY f, h
ORDER BY f, h;

CREATE TABLE ibd08.mstats
(
    f Date NOT NULL, 
    m UInt8 NOT NULL, 
    urls AggregateFunction(uniq, String),
    ips AggregateFunction(uniq, IPv4),
    uaids AggregateFunction(uniq, String),
    tot AggregateFunction(count, UInt32)
) ENGINE = AggregatingMergeTree ORDER BY (f, m);

CREATE MATERIALIZED view ibd08.mstats_mv
TO ibd08.mstats
AS SELECT
	toDate(ts) as f,
	toMonth(ts) as m,
	uniqState(url) as urls,
	uniqState(ip) AS ips,
	uniqState(uaid) AS uaids,
	countState(m) AS tot
FROM ibd08.accesos
GROUP BY f, m
ORDER BY f, m, urls;