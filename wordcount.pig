--pig wc.pig
A = load 'hdfs://cloudera-vm:8020/tmp/listofwords';

--A = load '/tmp/wc';
--ouput
--one two
--two three
--one
B = foreach A generate flatten(TOKENIZE((chararray)$0)) as word;
--output
--(one)
--(two)
--(two)
--(three)
--(one)

D = group B by word;
--output
--(one,{(one),(one)})
--(two,{(two),(two)})
--(three,{(three)})

E = foreach D generate group , COUNT(B);
--output
--(one,2)
--(two,2)
--(three,1)
store E into '/tmp/wc2';
