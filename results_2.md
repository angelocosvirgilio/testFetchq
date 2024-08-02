# Fetchq Performance Testing Results

## Test Setup

- **Number of Documents:** 1000
- **Payload Size per Document:** 7.5 MB
- **Interval Between Picks:** 50ms
- **System Configuration:** 1 CPU, 1GB RAM
- **Database:** PostgreSQL

## Test Results Summary

### Fetchq Version 4.0.0

| Label       | # Samples | Average | Median | 90% Line | 95% Line | 99% Line | Min  | Max  | Error % | Throughput | Received KB/sec | Sent KB/sec |
|-------------|-----------|---------|--------|----------|----------|----------|------|------|---------|------------|------------------|-------------|
| doc_append  | 1000      | 545     | 504    | 677      | 801      | 1469     | 364  | 2129 | 0.000%  | 1.70070    | 0.07             | 0.00        |
| doc_pick    | 1001      | 143     | 133    | 174      | 212      | 388      | 7    | 1245 | 0.000%  | 3.90403    | 24690.03         | 0.00        |
| TOTAL       | 2001      | 344     | 378    | 604      | 678      | 1270     | 7    | 2129 | 0.000%  | 2.36973    | 7497.18          | 0.00        |

### Fetchq Version 4.0.2

| Label       | # Samples | Average | Median | 90% Line | 95% Line | 99% Line | Min  | Max  | Error % | Throughput | Received KB/sec | Sent KB/sec |
|-------------|-----------|---------|--------|----------|----------|----------|------|------|---------|------------|------------------|-------------|
| doc_append  | 1000      | 507     | 492    | 611      | 665      | 746      | 370  | 862  | 0.000%  | 1.82455    | 0.08             | 0.00        |
| doc_pick    | 1001      | 129     | 124    | 159      | 175      | 224      | 2    | 706  | 0.000%  | 4.38725    | 27746.08         | 0.00        |
| TOTAL       | 2001      | 318     | 370    | 558      | 612      | 724      | 2    | 862  | 0.000%  | 2.57780    | 8155.47          | 0.00        |

## Analysis and Discussion

### Performance Overview

- **Append Operation:**
  - **Version 4.0.0:** The average response time for document append operations was 545 ms, with a maximum time of 2129 ms. Throughput was 1.70070 documents/sec, and the received bandwidth was 0.07 KB/sec.
  - **Version 4.0.2:** The average response time improved to 507 ms with a maximum time of 862 ms. Throughput increased to 1.82455 documents/sec, and the received bandwidth rose slightly to 0.08 KB/sec.

  **Discussion:** Version 4.0.2 shows a slight improvement in average response time and throughput for append operations. The reduction in maximum response time indicates better handling of peak loads or more efficient processing.

- **Pick Operation:**
  - **Version 4.0.0:** The average response time for picking documents was 143 ms, with a maximum of 1245 ms. The throughput was 3.90403 picks/sec, with a received bandwidth of 24690.03 KB/sec.
  - **Version 4.0.2:** The average response time improved to 129 ms, with a maximum of 706 ms. Throughput increased significantly to 4.38725 picks/sec, and the received bandwidth rose to 27746.08 KB/sec.

  **Discussion:** Version 4.0.2 demonstrated a notable enhancement in pick operation performance. The average response time and maximum latency both decreased, suggesting improved efficiency. The increase in throughput and bandwidth indicates better handling of high data volume during pick operations.

- **Total Performance:**
  - **Version 4.0.0:** The total average response time was 344 ms, with throughput at 2.36973 operations/sec and total received bandwidth of 7497.18 KB/sec.
  - **Version 4.0.2:** The total average response time decreased to 318 ms, with throughput at 2.57780 operations/sec and received bandwidth of 8155.47 KB/sec.

  **Discussion:** Version 4.0.2 shows an overall improvement in total performance metrics. The reduction in average response time and increase in throughput and bandwidth indicate better overall system efficiency and performance.

### Error Rates

Both versions show 0.000% error rates, suggesting that neither version encountered significant errors during the tests. This implies reliability in processing and retrieving documents under the given test conditions.

## Conclusion

Fetchq Version 4.0.2 outperforms Version 4.0.0 in terms of response times, throughput, and bandwidth utilization. These improvements make Version 4.0.2 a better choice for environments where document processing and retrieval performance are critical. The slight increases in throughput and bandwidth for append and pick operations, combined with reduced response times, highlight the optimizations and efficiency gains in Version 4.0.2.
