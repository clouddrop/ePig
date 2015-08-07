--a = load ' hdfs://localhost/uid_data' as (Registrar:chararray ,agency:chararray, dis:chararray , subdis:chararray , pin:int , gennder:chararray,age:int ,  aadhar_generate:int, rejected:int , email:int,phone:int );
a = load '/Users/samar.kumar/Downloads/UIDAI-ENR-DETAIL-20130704.csv' using PigStorage(',') as (Registrar:chararray ,agency:chararray, dis:chararray , subdis:chararray , pin:int , gennder:chararray,age:int ,  aadhar_generate:int, rejected:int , email:int,phone:int );

b =foreach a generate  *;
filtered = FILTER b by gennder='F';
c =  limit filtered 10;

dump c;