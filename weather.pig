----loading and parsing data-----

A = load '/pig/weather/input' using TextLoader as (data:chararray);
S = foreach A generate TRIM(SUBSTRING(data, 6, 14)) as date, (double)TRIM(SUBSTRING(data, 46, 53)) as min, (double)TRIM(SUBSTRING(data, 38, 45)) as max;
--store AF into '/data9' using PigStorage(',');
--S = load '/data9/part-m-00000' using PigStorage(',') as (date:chararray, min:double, max:double);

-------Hot Days------

X = filter S by max > 25;

-------Cold Days------

X = filter S by min < 0;

-------Hottest Day-----

--working example
H1 = group S all; 	/* puts S's data in H1's Tuple */
I = foreach H1 generate MAX(S.max) as maximum;
X = filter S by max == I.maximum;

-------Coldest Day------

H2 = group S all;
J = foreach H2 generate MIN(S.min) as minimum;
X = filter S by min == J.minimum;

register /home/edureka/pigudf.jar; 

-----UDF----- complete path of the udf -- can be added as a seperate file
register /home/edureka/Desktop/LMS/pig/2/Pig_Weather_example/udf_corrupt.jar;
A = load '/pig/weather/input' using TextLoader as (data:chararray);
AF = foreach A generate TRIM(SUBSTRING(data, 6, 14)) as date , IfCorrupted(TRIM(SUBSTRING(data, 46, 53))) as min, IfCorrupted(TRIM(SUBSTRING(data, 38, 45))) as max;
dump S;
