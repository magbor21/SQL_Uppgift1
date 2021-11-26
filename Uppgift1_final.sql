drop database if exists Uppgift1;
create database Uppgift1;
use	Uppgift1;

	/* The goal is (as always with SQL) no duplicates and no null values */
        
    /* Building the tables */
    
create table Spelare(
	PersonNr char(13) unique not null,
	Namn varchar(20) not null,
	Alder int not null,
	primary key(PersonNr)
);

create table Jacka(
	Material varchar(20) not null,
	Storlek varchar(5) not null,
	Modell varchar(20) not null,
    PersonNr char(13) not null,
    Initialer char(2) not null,
	foreign key (PersonNr) references Spelare(PersonNr),
	primary key (Modell, PersonNr)
);

create table Tavling(
	TavlingsNamn varchar(30) unique not null,
	Datum date not null,
	primary key (TavlingsNamn)
);

create table Deltar(
	PersonNr char(13) not null,
    TavlingsNamn varchar(30) not null,
    foreign key (PersonNr) references Spelare(PersonNr),
	foreign key (TavlingsNamn) references Tavling(TavlingsNamn),
    primary key (PersonNr, TavlingsNamn)
);

create table Konstruktion(
	SerialNr int unique not null,
	Hardhet int not null,
	primary key (SerialNr)
);

create table Klubba(
	Material varchar(10) not null,
	Nr int not null,
    PersonNr char(13) not null,
    SerialNr int not null,
    foreign key (SerialNr) references Konstruktion(SerialNr),
    foreign key (PersonNr) references Spelare(PersonNr),
    primary key (PersonNr, Nr)
);

create table Regn(
	Vader_Id int auto_increment unique not null,
    Typ varchar(10) not null,
	Vindstyrka int not null,
    primary key (Vader_Id)
);

create table Har(
	Tid time not null,
	TavlingsNamn varchar(30) not null,
    Vader_Id int not null,
    foreign key (Vader_Id) references Regn(Vader_Id),
    foreign key (TavlingsNamn) references Tavling(TavlingsNamn),
    primary key (Vader_Id, TavlingsNamn)
);

	/* Filling the tables */

			/* Eight players*/
insert into Spelare (PersonNr, Namn, Alder)
	values 	("19790924-0010","Magnus Borglund",42),
			("19800823-8034","Tom Armstrong",41),
            ("19810722-5611","Thomas Anderson",40),
            ("19820621-4544","Lena Moon",39),
            ("19830520-2211","Benson Dunwoody",38),
            ("19960601-1414","Johan Andersson",25),
            ("19991231-1401","Annika Persson",21),
            ("20000101-1410","Nicklas Jansson",21);

			/* Three competitions*/
insert into Tavling (TavlingsNamn, Datum)
	values	("Golf Cup Västra Götaland", "2021-12-31"),
			("Big Golf Cup Skövde","2021-06-10"),
            ("Gothia Fotgolfboll","2020-02-29");

			/* Some weather to choose from  */
insert into Regn (Typ, Vindstyrka)
	values	("Hagel",10),
			("Hagel",9),
            ("Regn",4),
            ("Regn",9),
            ("Snö",10),
            ("Snö",8),
            ("Snö",6),
            ("Snö",0),
            ("Snö",2);
            
            /* Jackets in all shapes and sizes */
insert into Jacka (Material,Storlek,Modell,PersonNr,Initialer)
	values	("Fleece","M","Höstjacka","19960601-1414","JA"),
			("GoreTex","M","Vinterjacka","19960601-1414","JA"),
            ("GoreTex","XL","Vinterjacka","19800823-8034","TA"),
            ("Läder","M","Långrock","19810722-5611","TA"),
            ("Polyuretan","S","Regnjacka","19820621-4544","LM"),
            ("GoreTex","S","VindJacka","19820621-4544","LM"),
            ("Bomull","L","Blazer","19830520-2211","BD"),
            ("Ull","M","Blazer","19960601-1414","JA"),
            ("Ull","M","Tweed","20000101-1410","NJ"),
            ("Ull","S","Tweed","19991231-1401","AP"),
            ("PVC/Bomull","M","Anorak","19991231-1401","AP");
			
            /* Serial numbers and hardness */
insert into Konstruktion (SerialNr,Hardhet)
	values 	(100100,10),
			(100101,9),
            (100110,8),
            (100111,7),
            (101000,4),
            (101001,5),
            (101010,10),
            (200100,1),
			(200101,2),
            (200110,3),
            (200111,4),
            (201000,5),
            (201001,6),
            (300100,1),
			(300101,2),
            (300110,3),
            (300111,4),
            (301000,5);
            
			/* Competitors in each Cup */
insert into Deltar(PersonNr, TavlingsNamn)
	values 	("19991231-1401","Golf Cup Västra Götaland"),
			("19960601-1414","Golf Cup Västra Götaland"),
            ("20000101-1410","Golf Cup Västra Götaland"),
            ("19790924-0010","Golf Cup Västra Götaland"),
            ("19800823-8034","Golf Cup Västra Götaland"),
            ("19820621-4544","Golf Cup Västra Götaland"),
            ("19830520-2211","Golf Cup Västra Götaland"),
            ("19810722-5611","Golf Cup Västra Götaland"),
            ("19800823-8034","Big Golf Cup Skövde"),
            ("20000101-1410","Big Golf Cup Skövde"),
            ("19991231-1401","Big Golf Cup Skövde"),
            ("19960601-1414","Big Golf Cup Skövde"),
            ("19790924-0010","Gothia Fotgolfboll"); /* Just me, on Heden, kicking a golf ball around :-) */
            
			/* A lot of bad weather at the Big Golf Cup Skövde */
insert into Har (Tid,TavlingsNamn,Vader_Id)
	values 	("12:00:00","Big Golf Cup Skövde",1),
			("13:00:00","Big Golf Cup Skövde",2),
            ("14:00:00","Big Golf Cup Skövde",3),
            ("13:37:00","Big Golf Cup Skövde",9),
            ("23:05:00","Big Golf Cup Skövde",7),
            ("08:18:00","Big Golf Cup Skövde",6),
            ("09:33:00","Big Golf Cup Skövde",5),
            ("20:02:29","Gothia Fotgolfboll",8);
              
			/* Some clubs for the players */
insert into Klubba(Material,Nr,PersonNr,SerialNr)
	values	("Trä",1,"20000101-1410",100100),
            ("Trä",1,"19991231-1401",101001),
            ("Trä",2,"19960601-1414",100101),
            ("Trä",3,"19830520-2211",100111),
            ("Trä",3,"19820621-4544",101000),
            ("Trä",4,"19810722-5611",101010),
            ("Trä",5,"19800823-8034",100110),
            ("Järn",5,"20000101-1410",200100),
			("Järn",5,"19991231-1401",200101),
            ("Järn",5,"19960601-1414",200110),
            ("Järn",5,"19830520-2211",200111),
            ("Järn",5,"19820621-4544",201000),
            ("Järn",5,"19810722-5611",201001),
            ("Putter",2,"20000101-1410",300100),
			("Putter",4,"19991231-1401",300101),
            ("Putter",3,"19960601-1414",300110),
            ("Putter",4,"19830520-2211",300111),
            ("Putter",1,"19820621-4544",301000);
            
	/* Operations */
		/* Presenation is important*/

            /* 1. Age of Johan Andersson */
select Namn, Alder from Spelare where PersonNr="19960601-1414";  

			/* 2. Date for Big Golf Cup Skövde */
select Tavlingsnamn, Datum from Tavling where Tavlingsnamn="Big Golf Cup Skövde"; 

			/* 3. Johan Andersson club material(s) */
select Klubba.Material, Spelare.Namn from Klubba
	inner join Spelare on Spelare.PersonNr=Klubba.PersonNr
    where Spelare.PersonNr = "19960601-1414";
    
			/* 4. All Jackets belonging to Johan Andersson  */
select Jacka.Modell, Jacka.Storlek, Jacka.Material, Spelare.Namn, Jacka.Initialer from Jacka
	inner join Spelare on Spelare.PersonNr=Jacka.PersonNr
    where Spelare.PersonNr = "19960601-1414";
    
			/* 5. All players at the Big Golf Cup Skövde   */
select Spelare.Namn, Deltar.Tavlingsnamn from Deltar
	inner join Spelare on Spelare.PersonNr=Deltar.PersonNr
    where Deltar.Tavlingsnamn = "Big Golf Cup Skövde";
    
			/* 6. How much wind when it rained at "Big Golf Cup Skövde" */
select  Har.Tid, Regn.Vindstyrka,Har.Tavlingsnamn from Har
	inner join Regn on Regn.Vader_Id=Har.Vader_Id
    where Har.Tavlingsnamn = "Big Golf Cup Skövde"
    order by Har.Tid;
    
			/* 7. Players younger than 30 */
select Namn, Alder from Spelare where Alder < 30
	order by Namn;

			/* 8. Delete Johan Anderssons Jackets and show that they are gone */
delete from Jacka where personNr="19960601-1414";
select Jacka.Modell, Jacka.Storlek, Jacka.Material, Spelare.Namn, Jacka.Initialer from Jacka
	inner join Spelare on Spelare.PersonNr=Jacka.PersonNr   
    order by Spelare.Namn;

			/* 9. Delete everything related to Nicklas Jansson*/
delete from Jacka where PersonNr = "20000101-1410";
delete from Deltar where PersonNr = "20000101-1410";
delete from Klubba where PersonNr = "20000101-1410";
delete from Spelare where PersonNr = "20000101-1410"; /* Finally delete the player*/
select Namn from Spelare;

			/* 10. Average age of players */
select avg(Alder) as MedelAlder, count(Alder) as AntalSpelare from Spelare;	
	/* should have been 33,375 before Nicklas was kicked out */