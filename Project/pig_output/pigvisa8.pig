visadata = LOAD '/home/hduser/Desktop/h1bvisa.csv' USING PigStorage('\t') AS (sno, case_status, employer_name, sco_name, job_title, time_postition, wage:INT, year:INT, worksite, longitude:DOUBLE, latitude:DOUBLE);

Filter_data = FOREACH visadata GENERATE $4 , $5 , $6 ,$7;

--dump Filter_data;

split Filter_data into PartTimeData if $1=='N', FullTimeData if $1=='Y';


part_time_year = GROUP PartTimeData by ($3 , $0);

--dump part_time_year;

full_time_year = GROUP FullTimeData by ($3 , $0);

--dump full_time_year;

PartTime_avg_wage = FOREACH part_time_year GENERATE group ,AVG(PartTimeData.$2), 'PartTime';

--dump PartTime_avg_wage;

FullTime_avg_wage = FOREACH full_time_year GENERATE group ,AVG(FullTimeData.$2), 'FullTime';

--dump FullTime_avg_wage ;

Combine_Bag = UNION PartTime_avg_wage,FullTime_avg_wage;

--dump Combine_Bag;

Result_order = ORDER Combine_Bag by $1 desc;


dump Result_order;

