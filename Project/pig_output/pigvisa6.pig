

visadata = LOAD '/home/hduser/Desktop/h1bvisa.csv' USING PigStorage('\t') AS (sno, case_status, employer_name, sco_name, job_title, time_postition, wage:INT, year:INT, worksite, longitude:DOUBLE, latitude:DOUBLE);

--grouping visa data into two forms

group_visa = group visadata by ($7,$1);

group_visa2 = group visadata by $7;

--finding the count for two groups of visa data

count1 = foreach group_visa2 generate group, COUNT(visadata);

count2 = foreach group_visa generate group, COUNT(visadata);


foreach_count2 = foreach count2 generate group.year,group.case_status, $1;

--dump foreach_count2;

joining = join foreach_count2 by $0, count1 by $0;

--dump joining;

final = foreach joining generate $0 ,$1, $2, ROUND_TO(((double)$2/$4)*100,2);

dump final
