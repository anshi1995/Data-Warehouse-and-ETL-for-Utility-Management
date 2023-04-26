An operational database is designed to store, manage and retrieve real-time transactional data. However, it is not powerful enough to handle the complexity and volume of data that can arise from handling a real-time utility management solution. Hence, it requires a database solution that is optimized for complex data analysis, provides scalability for large volumes of data, ensures data quality and consistency and offers a subject-oriented approach to data storage facilitating sound decision-making. Therefore, we propose a data warehouse design which will act as a central repository of our data from various sources and offer optimized data retrieval and analysis. 
We have proposed the following facts, dimensions and measures for the data warehouse design: 

**Facts:**

**1. Bills:** This fact deals with the analysis from the amount perspective and will facilitate the users understand the supply cost and delivery cost for different utilities, across various facility and their respective departments, current energy rates offered by the utility providers. Moreover, it supports date wise analysis including fiscal and calendar quarters and years. This fact contains the following measures: 
* Bill Amount 
* Unit Price
* Delivery Cost
* Supply Cost
* Usage Period

**2. Consumption:** This fact corresponds to the energy consumption in units and facilitate the analysis across different dimensions including the facilities and utility providers. Similar to the ‘Bills’ fact, it also supports date wise analysis. This fact contains the following measures:
* Number of Units
* Average Number of Units
* Usage Period

**Dimensions and Hierarchies:**

**1. Utility Provider**
*Hierarchies: 
* Utility Provider → Enterprise
* Utility Provider → Provider Category
* Utility Provider → City → State 

**2. Facility**
*Hierarchies:
* Facility → Department
* Facility → City → State 

**3. Payment**

**4. Date** 


**ERD Modeling for the Data Warehouse:**

The conceptual modeling for the data warehouse follows the Constellation Schema (due to the presence of 2 fact tables).
There are 4 dimension tables along with their respective hierarchy tables (ie normalized snowflake structure). This schema incorporates different categories of dimension hierarchies including parallel hierarchies, role-playing hierarchies, and balanced hierarchies. Some of these include **'Utility Affiliations'**, **'Utility Groups'** and **'Geography'** for the Utility Providers dimension table (parallel hierarchy), **'From Date'** and **'To Date'** for the Date dimension table (role-playing hierarchies) etc.
The Date dimension table, on the other hand, has been created in a non-normalized structure to allow for an easier analysis with respect to date and to avoid multiple joins between hierarchy tables when querying the data warehouse.
The fact table Bills has a 1-1 relationship with Invoice that stores the unique identifier of every invoice.
The measures Bill Amount, Delivery Cost, and Supply Cost are semi-additive since they can be aggregated across a few dimensions and not all. 
Moreover, the measures Unit Price and Usage Period are derived measures that will be calculated using other measures.

*Note: We have retained the IDs as surrogate keys for all the tables in the schema while extracting data from the operational database. Also, we are generating a key (primary key) at the data warehouse level. This allows for differentiation between the OLTP and OLAP databases and implementation of SCDs (slowly changing dimensions) as a future scope.
