-- windows总数从某个时间开始总共任务个数量-库pam
select count(1)
from pam.PAS_TASK_ACCOUNT t
         inner join pam.PAS_ACCOUNT t1 on t.PR_ACCOUNT_ID = t1.PR_ID
         inner join pam.pas_assets t2  on t1.PR_ASSETS_ID = t2.PR_ID
where t.PR_CREATE_TIME > '2024-08-12 00:00:00'
  and t.PR_CREATE_TIME < '2024-08-13 00:00:00'
  and t1.PR_DISABLE_PWD_MANAGE = 0
  and t2.PR_PLATFORM_TYPE_CODE = 'WINDOWS';

-- windows失败的任务数量-库pam
select count(1)
from (select t1.PR_ADDRESS,
             t1.PR_ACCOUNT_NUMBER,
             t2.PR_TEXT,
             t.PR_ID,
             t.PR_START_TIME,
             t.PR_END_TIME,
             t.PR_EXEC_TIME,
             t.PR_EXEC_DATE
      from pam.PAS_TASK_ACCOUNT t
               inner join pam.PAS_ACCOUNT t1
                          on t.PR_ACCOUNT_ID = t1.PR_ID
               inner join pam.PAS_TEXT t2
                          on t.PR_REASON_ID = t2.PR_ID
               inner join pam.pas_assets t3
                          on t1.PR_ASSETS_ID = t3.PR_ID
      where t.PR_STATUS = 3
        and t.PR_EXEC_RESULT = 0
        and t.PR_CREATE_TIME > '2024-08-12 00:00:00'
        and t.PR_CREATE_TIME < '2024-08-13 00:00:00'
        and t1.PR_DISABLE_PWD_MANAGE = 0
        and t3.PR_PLATFORM_TYPE_CODE = 'Windows') tmp
where tmp.PR_TEXT not like '%正在执行%';

-- win成功的pam数量
select count(1)
from pam.PAS_TASK_ACCOUNT t
         inner join pam.PAS_ACCOUNT t1
                    on t.PR_ACCOUNT_ID = t1.PR_ID
         inner join pam.pas_assets t3
                    on t1.PR_ASSETS_ID = t3.PR_ID
where t.PR_STATUS = 3
  and t.PR_EXEC_RESULT = 1
  and t1.PR_DISABLE_PWD_MANAGE = 0
  and t3.PR_PLATFORM_TYPE_CODE = 'Windows'
  and t.PR_CREATE_TIME > '2024-08-12 00:00:00'
  and t.PR_CREATE_TIME < '2024-08-13 00:00:00';

-- win失败的任务详情-pam
select *
from (select t1.PR_ADDRESS,
             t1.PR_ACCOUNT_NUMBER,
             t2.PR_TEXT,
             t.PR_ID,
             t.PR_START_TIME,
             t.PR_END_TIME,
             t.PR_EXEC_TIME,
             t.PR_EXEC_DATE
      from pam.PAS_TASK_ACCOUNT t
               inner join pam.PAS_ACCOUNT t1
                          on t.PR_ACCOUNT_ID = t1.PR_ID
               inner join pam.PAS_TEXT t2
                          on t.PR_REASON_ID = t2.PR_ID
               inner join pam.pas_assets t3
                          on t1.PR_ASSETS_ID = t3.PR_ID
      where t.PR_STATUS = 3
        and t.PR_EXEC_RESULT = 0
        and t.PR_CREATE_TIME > '2024-08-12 00:00:00'
        and t.PR_CREATE_TIME < '2024-08-13 00:00:00'
        and t1.PR_DISABLE_PWD_MANAGE = 0
        and t3.PR_PLATFORM_TYPE_CODE = 'Windows') tmp
where tmp.PR_TEXT not like '%正在执行%';
