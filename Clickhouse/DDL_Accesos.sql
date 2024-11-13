CREATE DATABASE ibd08;

CREATE TABLE ibd08.accesos
(
    ip IPv4 NOT NULL,
    uaid String NOT NULL,
    url String NOT NULL,
    osinfo Nullable(String),
    uaname Nullable(String),
    devname Nullable(String),
    meth Nullable(String),
    uref Nullable(String),
    status_code Nullable(Int32),
    ts DateTime64
) ENGINE = MergeTree ORDER BY (ip, uaid, url, ts);


CREATE TABLE ibd08.kafka_accesos
(
    IP String,
    UAID String,
    UTF8URL String,
    UAINFO Tuple(OSINFO Nullable(String), UANAME Nullable(String), DEVNAME Nullable(String)),
    HTTPINFO Tuple(MET Nullable(String), REF Nullable(String), STC Nullable(Int32)),
    APACHE_TS Nullable(DateTime64)
) ENGINE = Kafka()
SETTINGS
    kafka_broker_list = 'broker:9092',
    kafka_topic_list = 'ibd08.accesos',
    kafka_group_name = 'clickhouse',
    kafka_format = 'AvroConfluent',
    format_avro_schema_registry_url = 'http://schema-registry:8081';

SET stream_like_engine_allow_direct_select = 1;
SELECT * FROM ibd08.kafka_accesos limit 3;

CREATE MATERIALIZED VIEW ibd08.accesos_mv TO ibd08.accesos AS
SELECT
    IP as ip,
    UAID as uaid,
    UTF8URL as url,
    UAINFO.OSINFO as osinfo,
    UAINFO.UANAME as uaname,
    UAINFO.DEVNAME as devname,
    HTTPINFO.MET as meth,
    HTTPINFO.REF as uref,
    HTTPINFO.STC as status_code,
    APACHE_TS as ts
FROM ibd08.kafka_accesos;

SELECT * FROM ibd08.accesos_mv limit 3;
SELECT * FROM ibd08.accesos limit 3;

