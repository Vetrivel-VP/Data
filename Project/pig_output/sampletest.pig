h1b= LOAD '/home/vetri/Desktop/output' using  PigStorage('\t')  AS(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage,year, worksite1:chararray, worksite2:chararray, longitute, latitute);

datafile = foreach h1b generate $0,$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11;

Store aa into '/home/hduser/Desktop/join' using PigStorage('\t');
