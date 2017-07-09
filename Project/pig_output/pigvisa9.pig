visadata = LOAD '/home/hduser/Desktop/h1bvisa.csv' USING PigStorage('\t') AS (sno, case_status, employer_name, sco_name, job_title, time_postition, wage:INT, year:INT, worksite, longitude:DOUBLE, latitude:DOUBLE);

filter_data = FILTER visadata by ( $1 == 'CERTIFIED' ) OR ( $1 == 'CERTIFIED-WITHDRAWN' );

group1 = group filter_data by $2;

group2 = group visadata by $2;

count1 = FOREACH group1 GENERATE group , COUNT(filter_data.$0);

--dump count1;

count2 = FOREACH group2 GENERATE group , COUNT(visadata.$0);

--dump count2;

joining = JOIN count1 by $0 , count2 by $0;

--dump joining;

filtering = FILTER joining by $1>1000;

--dump filtering;

calc = FOREACH filtering GENERATE $0,$1,ROUND_TO(((double)$1/$3)*100,2);

--dump calc;

final = FILTER calc by $2>70;

dump final;
