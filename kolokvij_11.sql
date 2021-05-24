drop database if exists kolokvij_vjezba_11;
create database kolokvij_vjezba_11;
use kolokvij_vjezba_11;

create table djevojka(
	sifra int not null primary key auto_increment,
	kratkamajica varchar(45) not null,
	prstena int,
	ekstrovertno bit not null,
	majica varchar(42) not null,
	introvertno bit not null,
	svekrva int
);

create table punica(
	sifra int not null primary key auto_increment,
	carape varchar(33) not null,
	drugiputa datetime,
	majica varchar(40) not null,
	haljina varchar(30) not null,
	bojakose varchar(37) not null,
	djevojka int not null
);

create table punac(
	sifra int not null primary key auto_increment,
	jmbag char(11),
	kuna decimal(16,5) not null,
	vesta varchar(45) not null
);

create table mladic(
	sifra int not null primary key auto_increment,
	ogrlica int not null,
	stilfrizura varchar(35),
	drugiputa datetime not null,
	hlace varchar(45) not null
);

create table punac_mladic(
	sifra int not null primary key auto_increment,
	punac int not null,
	mladic int not null
);

create table svekrva(
	sifra int not null primary key auto_increment,
	narukvica int not null,
	carape varchar(39) not null,
	haljina varchar(31),
	punac int not null
);

create table neprijatelj(
	sifra int not null primary key auto_increment,
	narukvica int not null,
	novcica decimal(12,8) not null,
	bojakose varchar(39) not null,
	gustoca decimal(14,10),
	introvertno bit not null,
	asocijalno bit
);

create table muskarac(
	sifra int not null primary key auto_increment,
	maraka decimal(16,5),
	novcica decimal(13,10),
	nausnica int not null,
	narukvica int not null,
	gustoca decimal(12,6),
	neprijatelj int not null
);

alter table muskarac add foreign key (neprijatelj) references neprijatelj(sifra);

alter table punica add foreign key (djevojka) references djevojka(sifra);

alter table djevojka add foreign key (svekrva) references svekrva(sifra);

alter table svekrva add foreign key (punac) references punac(sifra);

alter table punac_mladic add foreign key (punac) references punac(sifra);
alter table punac_mladic add foreign key (mladic) references mladic(sifra);

#U tablice djevojka, svekrva i punac_mladic unesite po 3 retka.
insert into punac(kuna,vesta)
values(77.66,'Adidas'),(88.99,'S kapuljačom'),(100.02,'za po kući');

insert into mladic(ogrlica,drugiputa,hlace)
values(13,'2020-02-02','traper'),(14,'2021-01-10','poderane'),(15,'2018-04-05','od odijela');

insert into punac_mladic(punac,mladic)
values(1,1),(2,2),(3,3);

insert into svekrva(narukvica,carape,punac)
values(12,'pokemon',1),(14,'kratke ljetne',2),(20,'debele zimske',3);

insert into djevojka(kratkamajica,ekstrovertno,majica,introvertno)
values('adidas',0,'neka bezz',0),('nike',0,'polo',1),('puma',1,'crvena',1);

#U tablici muskarac postavite svim zapisima kolonu novcica na vrijednost 15,70.
update muskarac set novcica = 15.70;

#U tablici punica obrišite sve zapise čija je vrijednost kolone drugiputa 8. travnja 2019.
delete from punica where drugiputa = '2019-04-08';

#Izlistajte haljina iz tablice svekrva uz uvjet da vrijednost kolone carape sadrže slova ana.
select haljina
from svekrva s where s.carape like '&ana&';

/*Prikažite drugiputa iz tablice mladic, haljina iz tablice punica te
prstena iz tablice djevojka uz uvjet da su vrijednosti kolone carape iz
tablice svekrva počinju slovom a te da su vrijednosti kolone kuna iz
tablice punac različite od 21. Podatke posložite po prstena iz tablice
djevojka silazno.*/

#mladic,punica,djevojka, svekrva, punac
select m.drugiputa , p2.haljina , d.prstena 
from mladic m inner join punac_mladic pm on m.sifra = pm.mladic 
inner join punac p on p.sifra = pm.punac 
inner join svekrva s on s.punac = p.sifra 
inner join djevojka d on d.svekrva = s.sifra 
inner join punica p2 on p2.djevojka = d.sifra 
where s.carape like 'a%' and p.kuna != 21.00
order by d.prstena desc;

#Prikažite kolone kuna i vesta iz tablice punac čiji se primarni ključ ne nalaze u tablici punac_mladic.
select p.kuna , p.vesta 
from punac p left join punac_mladic pm on pm.punac = p.sifra 
where pm.punac is null;










