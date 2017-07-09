REGISTER /home/vetri/Downloads/piggybank-0.15.0.jar
DEFINE CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage;

h1bvisa = LOAD '/home/vetri/Downloads/PIG/Project/h1b.csv' USING CSVExcelStorage(',') AS (sno, status, employer_name, sco_name, job_title, time_postition, wage:INT, year:INT, worksite, longitude:float, latitude:float);



h1b_count = FOREACH (GROUP h1bvisa All) GENERATE COUNT(h1bvisa) as total;

filter_certified = FILTER h1bvisa BY ( $1 == 'CERTIFIED' ) OR ( $1 == 'CERTIFIED-WITHDRAWN' );

--data_group = GROUP filter_certified ALL;

data_count = FOREACH (GROUP filter_certified ALL) GENERATE COUNT(filter_certified) as cnt;

calc =foreach data_count GENERATE (float)2818282/3002458 as total_count;

calc1 = foreach calc GENERATE ROUND_TO((total_count*100),2) as success_rate;

--list = FILTER (FOREACH h1bvisa GENERATE $2, COUNT(employer_name)) BY calc1.success_rate > 70.00;


--final_count = foreach (GROUP list ALL) GENERATE COUNT(list) ;



dump finale;

