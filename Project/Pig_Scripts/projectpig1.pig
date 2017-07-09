dataeng = Load '/home/vetri/Desktop/sample.ods' USING PigStorage() AS (pos:int, status, empname, socname, jobname, time, wage:double, year, wroksite, longtitude:double, latitude:double);
dump dataeng;
