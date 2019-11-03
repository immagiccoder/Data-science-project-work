create table bajaj1 (`Date` text,`Close Price` double,MA20 Double,MA50 Double)as

SELECT 
 `Date`,`Close Price`,

       AVG(`Close Price`) OVER(ORDER BY `Date`  ASC ROWS BETWEEN 19 PRECEDING AND 
                                           CURRENT ROW) AS MA20,
			AVG(`Close Price`) OVER (ORDER BY `Date` ASC ROWS 49 PRECEDING ) AS MA50
       from bajajauto;
       
       create table eicher1 as

SELECT 
`Date`,`Close Price`,

       AVG(`Close Price`) OVER(ORDER BY `Date` ASC ROWS BETWEEN 19 PRECEDING AND 
                                           CURRENT ROW) AS MA20,
			AVG(`Close Price`) OVER (ORDER BY `Date` ASC ROWS 49 PRECEDING ) AS MA50
       from eichermotors;
       
       create table hero1 as

SELECT 
`Date`,`Close Price`,

       AVG(`Close Price`) OVER(ORDER BY `Date` ASC ROWS BETWEEN 19 PRECEDING AND 
                                           CURRENT ROW) AS MA20,
			AVG(`Close Price`) OVER (ORDER BY `Date` ASC ROWS 49 PRECEDING ) AS MA50
       from heromotocorp;
       
       
       create table infosys1 as

SELECT 
`Date`,`Close Price`,

       AVG(`Close Price`) OVER(ORDER BY `Date` ASC ROWS BETWEEN 19 PRECEDING AND 
                                           CURRENT ROW) AS MA20,
			AVG(`Close Price`) OVER (ORDER BY `Date` ASC ROWS 49 PRECEDING ) AS MA50
       from infosys;
       
       
       
       create table tcs1 as

SELECT 
`Date`,`Close Price`,
         
       AVG(`Close Price`) OVER(ORDER BY `Date` ASC ROWS BETWEEN 19 PRECEDING AND 
                                           CURRENT ROW) AS MA20,
			AVG(`Close Price`) OVER (ORDER BY `Date` ASC ROWS 49 PRECEDING ) AS MA50
       from tcs;
       
       
       
       create table tvs1 as

SELECT 
`Date`,`Close Price`,


       AVG(`Close Price`) OVER(ORDER BY year(`Date`) asc ROWS BETWEEN 19 PRECEDING AND 
                                           CURRENT ROW)  AS MA20,
	
			AVG(`Close Price`) OVER (ORDER BY year(`Date`) ASC ROWS BETWEEN 49 PRECEDING AND 
                                           CURRENT ROW)  AS MA50
       from tvsmotors;
       
       create table master_table
       select B1.`Date`,B1.`Close Price` as Bajaj,TC1.`Close Price` as TCS,T1.`Close Price` as TATA,Inf1.`Close Price` as Infosys,Eich1.`Close Price` as Eicher,H1.`Close Price` as Hero
from bajaj1 B1 inner join eicher1 Eich1 inner join hero1 H1 inner join infosys1 inf1 inner join tcs1 TC1 inner join tvs1 T1
on B1.`Date`=Eich1.`Date` and B1.`Date`=H1.`Date` and B1.`Date`=inf1.`Date` and B1.`Date`=TC1.`Date` and T1.`Date`=B1.`Date`;

 update bajaj1
set    `Date`=str_to_date(`Date`,'%d-%M-%Y') ;


create table bajaj2 

select `Date`,`Close Price`,

CASE

    WHEN  MA20 > MA50  and  lag(MA20 < MA50,1) over(order by `Date` asc) then 'Buy'
      WHEN (MA20 < MA50) and lag(MA20 > MA50,1) over(order by `Date` asc) THEN 'Sell'
    ELSE 'Hold'
END  as 'Signal'
from bajaj1 ;

update eicher1
set    `Date`=str_to_date(`Date`,'%d-%M-%Y') ;

create table eicher2 

select `Date`,`Close Price`,

CASE

    WHEN  MA20 > MA50  and  lag(MA20 < MA50,1) over(order by `Date` asc) then 'Buy'
      WHEN (MA20 < MA50) and lag(MA20 > MA50,1) over(order by `Date` asc) THEN 'Sell'
    ELSE 'Hold'
END  as 'Signal'
from eicher1 ;

update hero1
set    `Date`=str_to_date(`Date`,'%d-%M-%Y') ;

create table hero2 

select `Date`,`Close Price`,

CASE

    WHEN  MA20 > MA50  and  lag(MA20 < MA50,1) over(order by `Date` asc) then 'Buy'
      WHEN (MA20 < MA50) and lag(MA20 > MA50,1) over(order by `Date` asc) THEN 'Sell'
    ELSE 'Hold'
END  as 'Signal'
from hero1 ;

update infosys1
set    `Date`=str_to_date(`Date`,'%d-%M-%Y') ;

create table infosys2 

select `Date`,`Close Price`,

CASE

    WHEN  MA20 > MA50  and  lag(MA20 < MA50,1) over(order by `Date` asc) then 'Buy'
      WHEN (MA20 < MA50) and lag(MA20 > MA50,1) over(order by `Date` asc) THEN 'Sell'
    ELSE 'Hold'
END  as 'Signal'
from infosys1 ;

update tcs1
set    `Date`=str_to_date(`Date`,'%d-%M-%Y') ;

create table tcs2 

select `Date`,`Close Price`,

CASE

    WHEN  MA20 > MA50  and  lag(MA20 < MA50,1) over(order by `Date` asc) then 'Buy'
      WHEN (MA20 < MA50) and lag(MA20 > MA50,1) over(order by `Date` asc) THEN 'Sell'
    ELSE 'Hold'
END  as 'Signal'
from tcs1 ;

update tvs1
set    `Date`=str_to_date(`Date`,'%d-%M-%Y') ;

create table tvs2 

select `Date`,`Close Price`,

CASE

    WHEN  MA20 > MA50  and  lag(MA20 < MA50,1) over(order by `Date` asc) then 'Buy'
      WHEN (MA20 < MA50) and lag(MA20 > MA50,1) over(order by `Date` asc) THEN 'Sell'
    ELSE 'Hold'
END  as 'Signal'
from tvs1 ;



delimiter $$
create function get_signal (d date)

returns VARCHAR(10) deterministic
begin
declare s  varchar(10);
set s= (select `signal`  from bajaj2 
where `Date`= d );

return (s);
end
$$
delimiter ;

 select 

get_signal('2015-02-10') as getSignal

from bajaj2;

# Analysis Query
# 

select `signal`,`Date`,
avg(`Close Price`) over(order by `Date` asc rows  29 preceding  )as year_wise_max_close_price
 from infosys2
 ;
 
 
 
 
          
   
      
          
        
        
       



