# Performance and Resource Utilization Testing for Fetchq on PostgreSQL

This repository contains tools and scripts to test the performance and resource utilization of the PostgreSQL database with the Fetchq extension installed. The setup is largely containerized, with `docker-compose` commands managed partially via a `Makefile`.

## Table of Contents

- [Getting Started](#getting-started)
- [Running the Application](#running-the-application)
- [Running the Performance Tests](#running-the-performance-tests)
- [Measuring PostgreSQL Container Performance](#measuring-postgresql-container-performance)
- [Results](#results)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Docker
- Docker Compose
- Make
- JMeter (installed in your local environment)

## Running the Application

To start the application, use the following `make` command:

```sh
make start
```

If you want to install a different version of Fetchq (e.g., 4.0.2), you can specify the version parameter:

```sh
make start version=4.0.2
```

## Running the Performance Tests

1. Open JMeter and load the test plan located at load-tests/jmeter/testplans/test doc_append and doc_pick.jmx.
1. Run the test plan.

The test plan will perform the following actions:

- Insert 1000 entries into the queue q1 using the doc_append function with a payload of approximately 7.5 megabytes.
- Pick documents one by one from the queue using the doc_pick function.


The performance metrics for these operations will be recorded in the aggregate listener, which can be saved as a CSV file and placed in the load-tests/jmeter/results directory.

## Measuring PostgreSQL Container Performance

To measure the performance of the PostgreSQL container, run the following script from your terminal:

```sh
./stats_logger.sh
```

## Results

The performance metrics and resource utilization data collected during the tests can be found in the following locations:

- JMeter results: load-tests/jmeter/results
- PostgreSQL container stats: postgres_stats_*.log

## Contributing

Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
