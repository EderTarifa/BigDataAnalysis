# Real-Time Analysis Using ClickHouse and Kafka

## Introduction

This project focuses on building an end-to-end solution for real-time data processing and analysis using **Kafka** and **ClickHouse**. The pipeline is designed to collect, transform, and analyze web server log data in real-time.

The system ingests raw log data from an S3-compatible storage system into **Kafka**, where it is processed and transformed using **KSQL**. The transformed data is then analyzed and stored in **ClickHouse** for real-time analytics.

Key metrics such as IP addresses, user agents, and geolocation information are extracted, enabling the generation of detailed insights into web traffic patterns. The use of advanced SQL functions in ClickHouse, including window functions and aggregation combinators, allows for the creation of dynamic, up-to-date reports that monitor user behavior and system performance.

## Data Pipeline

1. **Data Loading**: Data is ingested from an S3-compatible storage into Kafka using the `ibd08-s3-source` connector.
2. **ETL Processing**: Kafka streams are processed using KSQL to extract and transform relevant data (IP, UAID, geolocation, etc.).
3. **Integration with ClickHouse**: Transformed data is loaded into ClickHouse, where it is processed using materialized views and aggregation functions for real-time analysis.
4. **Data Analysis**: Exploratory and statistical analyses are performed, generating insights into web traffic on an hourly and monthly basis.

## Technologies Used

- **Kafka**: For data ingestion and stream processing.
- **ClickHouse**: For real-time storage and analytics.
- **KSQL**: For stream processing and data transformation.
- **SQL**: For querying and analysis in ClickHouse.

## Features

- Real-time ingestion and transformation of web log data.
- Aggregation and analysis of web traffic data on an hourly and monthly basis.
- Scalable pipeline that supports efficient real-time analytics on large volumes of data.

## Setup

1. Clone the repository.
2. Configure Kafka and ClickHouse as per the setup instructions.
3. Load raw data into Kafka and start processing using KSQL.
4. Set up materialized views in ClickHouse to process and store the data.
5. Run SQL queries to analyze the data and generate insights.

## License

This project is licensed under the MIT License.
