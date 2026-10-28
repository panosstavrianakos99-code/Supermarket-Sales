# Supermarket Sales Data Warehouse and Power BI

A SQL Server and Power BI project that transforms supermarket transaction records into a relational model for sales analysis. The SQL workflow creates customer, product, store, date, and sales tables, then connects the prepared data to an interactive Power BI report.

## Analytical and data-modeling workflow

1. **Stage the source data.** Import the supermarket sales CSV into SQL Server as a staging table.
2. **Create dimensions.** Populate customer, product, store, and date tables from distinct source values.
3. **Build the sales fact table.** Join staged transactions to the dimension tables using customer, product, store, date, and time attributes. Calculate transaction totals from unit price and quantity in the database schema.
4. **Report.** Use the Power BI report to explore sales across the dimensions and measures modeled in the workbook.

## Tools and languages

- **T-SQL** for database creation, table definitions, loading, joins, and cleanup.
- **SQL Server** as the relational database engine.
- **Power BI** for interactive reporting and data exploration.

## Project files

- `schema_and_load.sql` — creates the database model and loads dimension and fact tables from the staging table.
- `supermarket_dashboard.pbix` — Power BI report.

## Data and setup

Import the supermarket sales CSV into SQL Server under the staging table name expected by `schema_and_load.sql`. Then open the PBIX file in Power BI Desktop, configure its SQL Server connection, and refresh the report.

## Data model

The model uses a central sales table linked to customer, product, store, and date dimensions. This structure supports slicing transaction measures by descriptive business attributes while keeping dimension values reusable across sales records.
