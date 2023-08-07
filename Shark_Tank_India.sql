SELECT * FROM project.data ;


-- total episodes

select max(epno) from project.data ;
select count(distinct epno) from project.data ;


-- pitches 

select count(distinct brand) from project.data ;

-- pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select Amount_Invested_lakhs,case when Amount_Invested_lakhs >0 then 1 else 0 end as converted_not_converted from project.data) a ;

-- total male

select sum(male) from project.data ;

-- total female

select sum(female) from project.data;

-- gender ratio

select sum(female)/sum(male) from project.data;

-- total invested amount

select sum(Amount_Invested_lakhs) from project.data;

-- avg equity taken

select avg(a.Equity_TakenP) from
(select * from project.data where Equity_TakenP>0) a ;

-- highest deal taken

select max(Amount_Invested_lakhs) from project.data ;

-- higheest equity taken

select max(Equity_TakenP) from project.data ;


--  startups having at total female count

SELECT SUM(a.female_count) AS total_female_count
FROM (
  SELECT female, CASE WHEN female > 0 THEN 1 ELSE 0 END AS female_count
  FROM project.data
) a
HAVING SUM(a.female_count) > 0 ;

-- pitches converted having atleast ne women

select * from project.data;

select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from project.data where deal!='No Deal')) a)b ;

-- avg team members

select avg(Team_members) from project.data ;

-- amount invested per deal

select avg(Amount_Invested_lakhs) amount_invested_per_deal from
(select * from project.data where deal!='No Deal') a ;

-- avg age group of contestants

select Avg_age,count(Avg_age) cnt from project.data group by Avg_age order by cnt desc ;

-- location group of contestants

select location,count(location) cnt from project.data group by location order by cnt desc ;

-- sector group of contestants

select sector,count(sector) cnt from project.data group by sector order by cnt desc ;


-- partner deals

select partners,count(partners) cnt from project.data  where partners!='-' group by partners order by cnt desc ;

-- making the matrix


select * from project.data ;

select 'Ashneer' as keyy,count(Aman_Amount_Invested) from project.data where Aman_Amount_Invested is not null;


select 'Ashneer' as keyy,count(Aman_Amount_Invested) from project.data where Aman_Amount_Invested is not null AND ashneer_amount_invested!=0 ;

SELECT 'Ashneer' as keyy,SUM(C.ASHNEER_AMOUNT_INVESTED),AVG(C.ASHNEER_EQUITY_TAKENP) 
FROM (SELECT * FROM PROJECT.DATA  WHERE ASHNEER_EQUITY_TAKENP!=0 AND ASHNEER_EQUITY_TAKENP IS NOT NULL) C ;


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count(ashneer_amount_invested) total_deals_present from project.data where ashneer_amount_invested is not null) a

inner join (
select 'Ashneer' as keyy,count(ashneer_amount_invested) total_deals from project.data 
where ashneer_amount_invested is not null AND ashneer_amount_invested!=0) b 

on a.keyy=b.keyy) m

inner join 

(SELECT 'Ashneer' as keyy,SUM(C.ASHNEER_AMOUNT_INVESTED) total_amount_invested,
AVG(C.ASHNEER_EQUITY_TAKENP) avg_equity_taken
FROM (SELECT * FROM PROJECT.DATA  WHERE ASHNEER_EQUITY_TAKENP!=0 AND ASHNEER_EQUITY_TAKENP IS NOT NULL) C) n

on m.keyy=n.keyy ;

-- which is the startup in which the highest amount has been invested in each domain/sector


select c.* from 
(select brand,sector,Amount_Invested_lakhs,rank() over(partition by sector order by Amount_Invested_lakhs desc) rnk 

from project.data) c

where c.rnk=1 ;
