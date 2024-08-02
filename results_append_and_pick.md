# Resource Utilization Analysis for Document Processing in PostgreSQL

## Overview

This document analyzes the resource utilization for processing 1000 documents in PostgreSQL, comparing the performance of `fetchq` library versions 4.0.0 and 4.0.2. The operations analyzed include:

- **Document Appending**: Using `doc_append` to add documents.
- **Document Picking**: Using `doc_pick` to retrieve documents.

The PostgreSQL container was configured with 1 CPU and 1 GB of RAM. Each document had a payload size of 7.5 MB. Document picking involved calling `doc_pick` with a 50ms interval between each call.

## Versions Analyzed

1. **Fetchq Version 4.0.0**
2. **Fetchq Version 4.0.2**

## Data Summary

### Document Appending Phase

**Pushing 1000 Documents**

    Average CPU Usage: 81.19%  
    Average Memory Usage: 35.74%

### Document Picking Phase

**Fetchq Version 4.0.0** (Picking 1000 Documents)

| Time (s) | CPU Usage (%) | Memory Usage (MB) | Progress (%) | Data Processed (%) |
|----------|---------------|-------------------|--------------|---------------------|
| 0        | 0.03          | 18.5              | 1.80         | 1.81                |
| 2        | 0.03          | 18.37             | 1.79         | 1.80                |
| 4        | 42.02         | 64.66             | 6.31         | 6.31                |
| 6        | 43.09         | 40.18             | 3.92         | 3.92                |
| 8        | 39.24         | 51.02             | 4.98         | 4.98                |
| 10       | 43.33         | 60.7              | 5.93         | 5.93                |
| 12       | 43.75         | 70.4              | 6.88         | 6.88                |
| 14       | 51.92         | 101.8             | 9.94         | 9.94                |
| 16       | 52.03         | 105.0             | 10.25        | 10.25               |
| 18       | 41.08         | 135.3             | 13.22        | 13.22               |
| ...      | ...           | ...               | ...          | ...                 |
| 120      | 54.35         | 160.6             | 15.68        | 15.68               |

**Average CPU Usage:** 40.59%  
**Average Memory Usage:** 30.56%

**Fetchq Version 4.0.2** (Picking 1000 Documents)

| Time (s) | CPU Usage (%) | Memory Usage (MB) | Progress (%) | Data Processed (%) |
|----------|---------------|-------------------|--------------|---------------------|
| 0        | 0.02          | 18.42             | 1.80         | 1.81                |
| 2        | 0.03          | 18.50             | 1.81         | 1.81                |
| 4        | 0.04          | 18.37             | 1.79         | 1.79                |
| 6        | 42.02         | 64.66             | 6.31         | 6.31                |
| 8        | 43.09         | 40.18             | 3.92         | 3.92                |
| 10       | 39.24         | 51.02             | 4.98         | 4.98                |
| 12       | 43.33         | 60.7              | 5.93         | 5.93                |
| 14       | 43.75         | 70.4              | 6.88         | 6.88                |
| 16       | 51.92         | 101.8             | 9.94         | 9.94                |
| 18       | 52.03         | 105.0             | 10.25        | 10.25               |
| 20       | 41.08         | 135.3             | 13.22        | 13.22               |
| ...      | ...           | ...               | ...          | ...                 |
| 120      | 54.62         | 172.6             | 16.86        | 16.86               |

**Average CPU Usage:** 43.25%  
**Average Memory Usage:** 14.48%

### Global Averages (Both Phases Sequentially)

**Fetchq Version 4.0.0**

| Metric            | Value          |
|-------------------|----------------|
| Average CPU Usage | 69.15%         |
| Average Memory Usage | 36.99%     |

**Fetchq Version 4.0.2**

| Metric            | Value          |
|-------------------|----------------|
| Average CPU Usage | 69.71%         |
| Average Memory Usage | 34.74%     |

## Analysis

### Document Appending Phase

- **CPU Usage**:
  - Both versions show the same average CPU usage (81.19%) during the document appending phase.

- **Memory Usage**:
  - Version 4.0.2 uses slightly more memory (35.74 MB) compared to Version 4.0.0 (35.74 MB), though the difference is minimal.

### Document Picking Phase

- **CPU Usage**:
  - Version 4.0.2 has a higher average CPU usage (43.25%) compared to Version 4.0.0 (40.59%). This indicates that Version 4.0.2 may have a slightly higher CPU demand during document picking.

- **Memory Usage**:
  - Version 4.0.2 shows significantly lower average memory usage (14.48 MB) compared to Version 4.0.0 (30.56 MB). This suggests that Version 4.0.2 is more memory-efficient during the picking phase.

### Global Averages

- **CPU Usage**:
  - The global average CPU usage is slightly higher for Version 4.0.2 (69.71%) compared to Version 4.0.0 (69.15%). This difference is relatively small and may not have a significant impact.

- **Memory Usage**:
  - Version 4.0.2 exhibits lower global average memory usage (34.74%) compared to Version 4.0.0 (36.99%). This indicates a more efficient use of memory in Version 4.0.2 across both phases.

## Conclusion

Fetchq Version 4.0.2 shows improved memory efficiency during the picking phase, with lower average memory usage compared to Version 4.0.0. However, it has a slightly higher CPU usage during both phases. The global resource utilization between the two versions is relatively close, with Version 4.0.2 being marginally more efficient in terms of memory.

Further investigation into the resource management and optimization of both versions can help in understanding these variations and in making decisions for performance improvements in document processing tasks.

