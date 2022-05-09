CREATE TABLE Rosters(
   Rk int
  ,Team_ID VARCHAR(3) PRIMARY KEY 
  ,Tm VARCHAR(30) 
  ,C VARCHAR(255) 
  ,1B VARCHAR(255) 
  ,2B VARCHAR(255) 
  ,3B VARCHAR(255) 
  ,SS VARCHAR(255) 
  ,LF VARCHAR(255) 
  ,CF VARCHAR(255) 
  ,RF VARCHAR(255) 
  ,DH VARCHAR(255) 
);
CREATE TABLE Teams(
   Team_ID     VARCHAR(3)
  ,Tm          VARCHAR(21) NOT NULL
  ,atAS        INTEGER  NOT NULL
  ,Est_Payroll INTEGER  NOT NULL
  ,Wins        INTEGER  NOT NULL
  ,Losses      INTEGER  NOT NULL
  ,League_ID     VARCHAR(2) REFERENCES Leagues(League_ID),
  Primary KEY (League_ID, Team_ID)
);
CREATE TABLE Players(
   Rk    INTEGER 
  ,Name VARCHAR(21) NOT NULL
  ,Age   INTEGER 
  ,Tm    VARCHAR(3) Primary KEY
  ,G     INTEGER  
  ,H     INTEGER  
  ,HR    INTEGER 
  ,BA    NUMERIC(5,3)
);

CREATE TABLE Managers(
   Rk        INTEGER  NOT NULL
  ,Mgr       VARCHAR(15) NOT NULL
  ,Team_ID   VARCHAR(3) NOT NULL PRIMARY KEY
  ,Ejections INTEGER  NOT NULL
  ,Age       INTEGER  NOT NULL
);

CREATE TABLE Leagues(
   Rk        INTEGER 
  ,Lg        VARCHAR(28) NOT NULL
  ,Lev       VARCHAR(17) NOT NULL
  ,Tms       INTEGER  NOT NULL
  ,League_ID VARCHAR(2) PRIMARY KEY
);



/* Example Queries for use */
/* Subqueries*/
SELECT Name, Age, BA, HR 
FROM (SELECT * FROM Players WHERE AGE > 32)
WHERE HR >30;

/*Aggregate*/
/* this gives the average payroll for each team where they have wins above 85  */
SELECT avg(Est_Payroll) FROM TEAMS WHERE Wins > 85;

/* Insertion */
/* Rebuilding the Montreal Expos */
INSERT INTO  Teams(Team_ID,Tm, atAS,Est_Payroll,Wins,Losses,League)
VALUES (MTL,Montreal Expos,3,100000000,130,32,NL);

/* Update */
/* MAybe use for a trade of catchers between the Diamondbacks and the Yankees*/

Update Rosters
SET C = 
    CASE Team_ID
    WHEN 'NYY' THEN (SELECT C FROM Rosters WHERE C = 'ARI')
    WHEN 'ARI' THEN (SELECT C FROM Rosters WHERE C = 'NYY')
    END
WHERE C IN ('NYY','ARI');

/*Use Case*/
/* This query can be used to display the spending gap between the top 2 teams */
SELECT Est_Payroll FROM Teams ORDER by Wins DESC limit 2;

