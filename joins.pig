number = load '/Users/samar.kumar/Documents/edureka/ePig/data/join1' using PigStorage(' ') as (row:int , number_name:chararray );
fruit = load '/Users/samar.kumar/Documents/edureka/ePig/data/join2' using PigStorage(' ') as (row:int , fruit:chararray );

number = load '/pig/input/number' using PigStorage(' ') as (row:int , number_name:chararray );
fruit = load '/pig/input/fruit' using PigStorage(' ') as (row:int , fruit:chararray );


DESCRIBE number
DESCRIBE fruit


ordered_number = ORDER number BY number_name;
limit_number = limit ordered_number  2;
union_all = UNION number, fruit;


data1 data2
data3 data4


please show this ----
SPLIT number INTO part1 IF row<5,part2 IF row >=5;


filter_number = FILTER number BY (row>8);	


part1 = FILTER number BY (row<5);	
part2= FILTER number BY (row>=5);

forEach_number = FOREACH number GENERATE  row;
dist_number = distinct forEach_number;

dump number;

cogrouped  = COGROUP number by row , fruit by row;
(1,{(1,one),(1,ek)},{(1,apple)})
(2,{(2,two)},{(2,orange)})
(3,{(3,three)},{})
(5,{},{(5,grapes)})
(20,{(20,twenty)},{})


join_result = JOIN number by row , fruit by row;

join_result_left = JOIN number by row LEFT OUTER, fruit by row;


full_join_result = JOIN number by row full, fruit by row;
cross_result = CROSS number , fruit;
--show co-grou
group_number = group number by row
group_fruit = group fruit by row;
join_group = JOIN group_number by group full, group_fruit by group;

full join



(1,{(1,one),(1,ek)},1,{(1,apple)})
(2,{(2,two)},2,{(2,orange)})
(3,{(3,three)},,)
(,,5,{(5,grapes)})
(20,{(20,twenty)},,)


explain dist_number 
illustrate cogrouped;




join_left_outer = JOIN number by row LEFT OUTER, fruit by row;


flatten_group = FOREACH cogrouped GENERATE FLATTEN(number) ,FLATTEN(fruit) ;

--cogropued result
(1,{(1,one),(1,ek)},{(1,apple)})
(2,{(2,two)},{(2,orange)})
(3,{(3,three)},{})
(5,{},{(5,grapes)})
(20,{(20,twenty)},{})

--flatten result
(1,one,1,apple)
(1,ek,1,apple)
(2,two,2,orange)



	
filter_number = FILTER number BY (row==8);		
filter_number = FILTER number BY (f1==8) OR (NOT (f2+f3 > f1));							
nested access
								
forEach_a = FOREACH cogrouped GENERATE number.row;



--UDF
REGISTER /Users/samar.kumar/cdh3/pig-0.8.1-cdh3u6/my-udf/myudf.jar  

register /home/edureka/pigudf.jar; 

number_upper  = FOREACH number GENERATE row , samar.udf.UPPER(number_name)

number_filter_udf = FILTER number by samar.udf.ISADULT(row);





DEFINE myUpper samar.udf.UPPER();
my_upper  = FOREACH number GENERATE row , myUpper(number_name);


dump number ;

store E into '/tmp/wc2';



number = load 'hdfs://localhost:54310/' using PigStorage(' ') as (row:int , number:chararray );
fruit = load 'hdfs://localhost:54310/2Demographic_Statistics_By_Zip_Code.csv' using PigStorage(' ') as (row:int , fruit:chararray );