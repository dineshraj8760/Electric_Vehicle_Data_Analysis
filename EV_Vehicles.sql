create database e_vehicles;

use e_vehicles;

CREATE TABLE electric_vehicle_data (
  `VIN (1-10)` VARCHAR(20),
  `County` VARCHAR(50),
  `City` VARCHAR(100),
  `State` VARCHAR(50),
  `Postal Code` VARCHAR(20),
  `Model Year` INT,
  `Make` VARCHAR(50),
  `Model` VARCHAR(100),
  `Electric Vehicle Type` VARCHAR(100),
  `Clean Alternative Fuel Vehicle (CAFV) Eligibility` VARCHAR(100),
  `Electric Range` INT,
  `Base MSRP` INT,
  `Legislative District` VARCHAR(20),
  `DOL Vehicle ID` INT NULL,
  `Vehicle Location` VARCHAR(100),
  `Electric Utility` VARCHAR(100),
  `2020 Census Tract` VARCHAR(50)
);

ALTER TABLE electric_vehicle_data
  MODIFY COLUMN `PostalCode` VARCHAR(20),
  MODIFY COLUMN `DOLVehicleID` INT NULL;
  
ALTER TABLE electric_vehicle_data 
MODIFY COLUMN `DOLVehicleID` VARCHAR(20) NULL;


select * from electric_vehicle_data;

-- Show only unique States in the dataset.

select distinct State
from electric_vehicle_data;

-- Find all vehicles registered in ‘Seattle’ city.

select * from
electric_vehicle_data
where city = 'Seattle';

-- List all vehicles manufactured by Tesla.

select * from 
electric_vehicle_data
where Make ='TESLA';

-- Show all vehicles with Electric Range > 200 miles.

select * from 
electric_vehicle_data 
where ElectricRange > 200;

-- Sort all vehicles by Base MSRP in descending order

select * from 
electric_vehicle_data order by BaseMSRP desc;

-- Display vehicles from the year 2023 and State = ‘Seattle'.

SELECT *
FROM electric_vehicle_data
WHERE ModelYear = 2023
AND City = 'Seattle';

-- Count how many different EV Types exist in the dataset.

select distinct(ElectricVehicleType)
from electric_vehicle_data ;

-- List the top 10 most expensive EV models by MSRP.

select ModelYear,Make,Model,ElectricVehicleType,BaseMSRP
from electric_vehicle_data 
order by BaseMSRP desc
limit 10;

-- Retrieve all records where the Model name starts with ‘N’.

select * from electric_vehicle_data
where Model like 'N%';


-- Find vehicles whose Base MSRP is between $30,000 and $70,000.

select * from electric_vehicle_data
where BaseMSRP between 30000 and 70000;

-- Get all vehicles where Make IN (‘Tesla’, ‘Nissan’, ‘Chevrolet’).

select * from electric_vehicle_data 
where Make in ('Tesla', 'Nissan','Chevrolet');


-- Show all vehicles not eligible for Clean Alternative Fuel Vehicle (CAFV).

select * from electric_vehicle_data
where not CAFVEligibility =  'Clean Alternative Fuel Vehicle Eligible';

-- Find vehicles with Electric Range < 100 OR MSRP < 30,000.

select* from electric_vehicle_data
where ElectricRange < 100 OR BaseMSRP < 30000; 

-- Display records where City LIKE 'Lake'.

select * from electric_vehicle_data
where City like '%Lake%';

-- Count total number of EVs by Make.

select count(*),Make
from electric_vehicle_data
group by Make;

-- Find the average Electric Range by EV Type.

select ElectricVehicleType,avg(ElectricRange) from electric_vehicle_data
group by ElectricVehicleType;

-- Calculate average MSRP per Model Year.

Select Make,Model,ModelYear, avg(BaseMSRP) as avg_price
from electric_vehicle_data
group by Model,ModelYear,Make
order by ModelYear;

-- Get total number of vehicles by City.

select count(*) as vehicles_count ,City from electric_vehicle_data
group by City;

-- Find minimum and maximum Electric Range per Make.

select Make,max(ElectricRange) as max_range from 
electric_vehicle_data
group by Make;

select Make,min(ElectricRange) as min_range from
electric_vehicle_data
group by Make;

-- Find all vehicles whose Base MSRP is above the overall average MSRP.

select * from electric_vehicle_data
where BaseMSRP > (select avg(BaseMSRP) from electric_vehicle_data);

-- List all Makes having more than 500 EVs registered

select Make,count(*) as no_of_vehicles from electric_vehicle_data
group by Make
having count(*) > 500;

-- Find Makes where average MSRP is greater than the average MSRP of Tesla vehicles.

select * from electric_vehicle_data
 where  Make = 'TESLA'
and  BaseMSRP > (select avg(BaseMSRP) from electric_vehicle_data);		

-- classify the ev vehicles

select 
case 
when 
ElectricRange < 100 then 'short_range'
when ElectricRange between 100 and 200 then 'medium_range'
when ElectricRange > 300 then 'Long_range'
end as Range_Details
from electric_vehicle_data;

	
-- Rank the Top 5 Cities by total EV registrations.

select *, rank() over(partition by City) as top_ranks 
from electric_vehicle_data;

-- Assign a unique rank to each EV ordered by MSRP.

select * , rank() over(partition by Make order by BaseMSRP) as price_ranks 
from electric_vehicle_data;

-- Top 3 Models by range per manufacturer.

select * , dense_rank() over (partition by Model order by ElectricRange) as top3
from electric_vehicle_data;

-- All vehicles into quartiles based on price.

select *,ntile(4) over (order by BaseMSRP desc) as price_split
from electric_vehicle_data;

-- For each Make, show its average range, average MSRP, and rank by total EV count.

select Make,avg(ElectricRange) as avg_range,avg(BaseMSRP) as avg_price,
rank() over(order by count(*)) as ranks
from electric_vehicle_data
group by Make;

	




















