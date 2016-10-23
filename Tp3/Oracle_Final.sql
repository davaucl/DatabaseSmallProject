drop table TP_2_CENTRE_DE_RECHERCHE cascade constraints; 
drop table TP_2_PATIENT cascade constraints; 
drop table TP_2_VARIATION_GENETIQUE cascade constraints; 
drop table TP_2_DROGUE cascade constraints; 
drop table TP_2_FABRICANT cascade constraints;
drop table TP_2_FORMULE_MASSE_DROGUE cascade constraints;
drop table TP_2_DROGUE_VARIANT cascade constraints;
drop table TP_2_ETUDE cascade constraints;
drop table TP_2_ETUDE_PATIENT cascade constraints;
drop table TP_2_ARTICLE cascade constraints;
drop table TP_2_AUTEUR_ARTICLE cascade constraints;


create table TP_2_ARTICLE (
NO_ARTICLE varchar2(50) not null,
TITRE_ART varchar2(200) null,
DATE_ART varchar2(15) null,
NOM_REVUE_ART varchar2(200) null,
NUM_REVUE_ART varchar2(8) null,
NUM_PAGE_ART varchar2(8) null, 
RESUME_ART varchar2(1000) null,
constraint PK_TP_2_ARTICLE primary key(NO_ARTICLE)
);

create table TP_2_FORMULE_MASSE_DROGUE (
FORMULE_DROGUE varchar2(80) not null,
MASSE_MOL_DRO varchar2(15) null,
constraint PK_TP_2_FORMULE_MASSE_DROGUE primary key(FORMULE_DROGUE)
);


create table TP_2_CENTRE_DE_RECHERCHE (
NO_CENTRE_RECHERCHE varchar2(10) not null,
NOM_CEN_RECHERCHE varchar2(100) null,
ADRESSE_CEN_RECH varchar2(150) null,
VILLE_CEN_RECH varchar2(50) null,
PROVINCE_CEN_RECH varchar2(40) null,
constraint PK_TP_2_CENTRE_DE_RECHERCHE primary key(NO_CENTRE_RECHERCHE)
);

create table TP_2_PATIENT (
NO_PATIENT varchar2(15) not null, 
REGION_PAT varchar2(35) null,
AGE_PAT varchar2(3) null,
GENRE_PAT char(1) null,
PROVINCE_PAT varchar2(20) null,
INDICE_EFFICACITE_METABO_PAT varchar2(4) null,
constraint PK_TP_2_PATIENT primary key(NO_PATIENT),
constraint CT_GENRE_PAT check (GENRE_PAT in ('M' , 'F'))
);


create table TP_2_VARIATION_GENETIQUE (
NO_VARIANT_GENETIQUE varchar2(10) not null ,
NUCLEOTIDE_VAR char(1) null,
NUCLEOTIDE_REF char(1) null,
GENE_VAR varchar2(10) null,
CHROMOSONE_VAR varchar2(10) null,
constraint PK_TP_2_VARIATION_GENETIQUE primary key(NO_VARIANT_GENETIQUE)
);


create table TP_2_DROGUE (
NO_DROGUE varchar2(15)not null,
NOM_DRO varchar2(15) null,
FORMULE_DROGUE varchar2(20) null,
URL_DRO varchar2(1000) null,
DOSE_ENF_DRO varchar2(5) null,
DOSE_ADU_DRO varchar2(5) null,
TEMP_DEMI_VIE_DRO varchar2(10) null,
CONCENTRATION_SANG_DRO varchar2(5) null,
COUT_DRO varchar2(9) null,
constraint PK_TP_2_DROGUE primary key(NO_DROGUE),
constraint FK_TP_2_DROGUE foreign key (FORMULE_DROGUE)
references TP_2_FORMULE_MASSE_DROGUE (FORMULE_DROGUE) on delete cascade
);


create table TP_2_FABRICANT (
NO_DROGUE varchar2(10) not null, 
NUM_FAB varchar2(8) null,
NOM_FAB varchar2(20) null,
constraint PK_TP_2_FABRICANT primary key(NO_DROGUE, NUM_FAB),
constraint FK_TP_2_FABRICANT foreign key (NO_DROGUE)
references TP_2_DROGUE (NO_DROGUE) on delete cascade
);


create table TP_2_DROGUE_VARIANT (
NO_DROGUE varchar2(10) not null, 
NO_VAR_GEN varchar2(8) not null,
EST_EFFET_TOX varchar2(20) null,
EST_EFFET_EFFICACITE varchar2(20) null,
EST_EFFET_METABOLISME varchar2(20) null,
EST_EFFET_AUTRE varchar2(20) null,
INDICE_EFFICACITE_METABO_DV number(4,2) null,
constraint PK_TP_2_DROGUE_VARIANT primary key(NO_DROGUE, NO_VAR_GEN),
constraint FK_TP_2_DROGUE_FABRICANT foreign key (NO_DROGUE)
references TP_2_DROGUE (NO_DROGUE) on delete cascade,
constraint FK2_TP_2_DROGUE_FABRICANT foreign key (NO_VAR_GEN)
references TP_2_VARIATION_GENETIQUE (NO_VARIANT_GENETIQUE) on delete cascade
);


create table TP_2_ETUDE (
NO_ETUDE varchar2(10) not null,
NO_CEN_RECH varchar2(50) null,
NO_DROGUE varchar2(100) null,
NO_VAR_GEN varchar2(200) null,
NO_ARTICLE varchar2(15) null,
NO_ETUDE_PARENT varchar2(15) null,
DATE_DEBUT_ET varchar2(10) null,
DATE_FIN_ET varchar2(10) null, 
TITRE_ET varchar2(50) null,
constraint PK_TP_2_ETUDE primary key(NO_ETUDE),
constraint FK_TP_2_ETUDE foreign key (NO_CEN_RECH)
references TP_2_CENTRE_DE_RECHERCHE (NO_CENTRE_RECHERCHE)on delete cascade,
constraint FK2_TP_2_ETUDE foreign key (NO_DROGUE)
references TP_2_DROGUE (NO_DROGUE) on delete cascade,
constraint FK3_TP_2_ETUDE foreign key (NO_VAR_GEN)
references TP_2_VARIATION_GENETIQUE (NO_VARIANT_GENETIQUE)on delete cascade,
constraint FK4_TP_2_ETUDE foreign key (NO_ARTICLE)
references TP_2_ARTICLE (NO_ARTICLE) on delete cascade,
constraint FK5_TP_2_ETUDE foreign key (NO_ETUDE_PARENT)
references TP_2_ETUDE (NO_ETUDE) on delete cascade
);


create table TP_2_ETUDE_PATIENT (
NO_ETUDE varchar2(10) not null, 
NUM_PATIENT_ETUDE varchar2(8) null,
NO_PATIENT varchar2(8) null,
constraint PK_TP_2_ETUDE_PATIENT primary key(NO_ETUDE, NUM_PATIENT_ETUDE),
constraint FK_TP_2_ETUDE_PATIENT foreign key (NO_ETUDE)
references TP_2_ETUDE (NO_ETUDE) on delete cascade,
constraint FK2_TP_2_ETUDE_PATIENT foreign key (NO_PATIENT)
references TP_2_PATIENT(NO_PATIENT) on delete cascade
);



create table TP_2_AUTEUR_ARTICLE (
NO_ARTICLE varchar2(50) not null,
NUM_AUTEUR varchar2(15) not null,
AUTEUR varchar2(60) null,
constraint PK_TP_2_AUTEUR_ARTICLE primary key(NO_ARTICLE, NUM_AUTEUR),
constraint FK_TP_2_AUTEUR_ARTICLE foreign key (NO_ARTICLE)
references TP_2_ARTICLE(NO_ARTICLE) on delete cascade
);






















-- 1 b 




insert into TP_2_ARTICLE 
(NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)
values ('1235', 'broad-spectrum cephalosporin','1999-04-14','The in-vitro world', '12', '150',
'a novel broad-spectrum cephalosporin: in vitro and in vivo antibacterial activities. Antimicrob Agents Chemother');

insert into TP_2_ARTICLE 
(NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)
values ('1234', 'Ramesseum medical papyri','1800-06-18','Ancient Egypt', '21', '49',
'As with most ancient Egyptian medical papyri, these documents mainly dealt with ailments, 
diseases, the structure of the body, and supposed remedies used to heal these afflictions,
namely ophthalmologic ailments, gynaecology, muscles, tendons, and diseases of children.');

insert into TP_2_ARTICLE 
(NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)
values ('1233', 'Hursts the Heart','2003-01-01','The heart of the heart', '13', '600',
' medical textbook published by McGraw-Hill Education. First released in 1966, it is currently in its 13th edition.
It covers the field of cardiology and is one of the most widely used medical textbooks in the world');

insert into TP_2_ARTICLE 
(NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)
values ('1232', 'The Oxford Textbook of Medicine','2010-09-15','Oxford Texbook', '20', '125',
' Primarily aimed at mature physicians looking for information outside their area of particular expertise');

insert into TP_2_ARTICLE 
(NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)
values ('1231', 'Miller-Keane Encyclopedia & Dictionary of Medicine Nursing and Allied Health','1996-12-25','Encyclopedia mania', '140', '268',
'The entries are alphabetical and compiled with multidisciplinary collaboration Illustrations and tables were included from the sixth edition.');

insert into TP_2_FORMULE_MASSE_DROGUE
(FORMULE_DROGUE, MASSE_MOL_DRO)
values('C16H17N9O5S3','132');

insert into TP_2_FORMULE_MASSE_DROGUE
(FORMULE_DROGUE, MASSE_MOL_DRO)
values('C14H18N6O','21');

insert into TP_2_FORMULE_MASSE_DROGUE
(FORMULE_DROGUE, MASSE_MOL_DRO)
values('C10H16N2O3','687');

insert into TP_2_FORMULE_MASSE_DROGUE
(FORMULE_DROGUE, MASSE_MOL_DRO)
values('C12N2O38','451');

insert into TP_2_FORMULE_MASSE_DROGUE
(FORMULE_DROGUE, MASSE_MOL_DRO)
values('NE10H1N6O9','90');

insert into TP_2_CENTRE_DE_RECHERCHE 
(NO_CENTRE_RECHERCHE, NOM_CEN_RECHERCHE, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
values ('15', 'Centre de recherche de Londre', '126 Stockwell green', 'Londre', 'Ontario' );

insert into TP_2_CENTRE_DE_RECHERCHE 
(NO_CENTRE_RECHERCHE, NOM_CEN_RECHERCHE, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
values ('16', 'Centre de recherche de Ottawa', '130 Linen avenue', 'Ottawa', 'Ontario' );

insert into TP_2_CENTRE_DE_RECHERCHE 
(NO_CENTRE_RECHERCHE, NOM_CEN_RECHERCHE, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
values ('17', 'Centre de recherche de Quebec', '40 boul. Laurier', 'Quebec', 'Quebec' );

insert into TP_2_CENTRE_DE_RECHERCHE 
(NO_CENTRE_RECHERCHE, NOM_CEN_RECHERCHE, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
values ('18', 'Centre de recherche de Banff', '3500 hudson street', 'Banff', 'Alberta' );

insert into TP_2_CENTRE_DE_RECHERCHE 
(NO_CENTRE_RECHERCHE, NOM_CEN_RECHERCHE, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
values ('19', 'Centre de recherche de Vancouver', '34 clapton avenue', 'Vancouver', 'British Colombia' );


insert into TP_2_PATIENT
(NO_PATIENT, REGION_PAT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, INDICE_EFFICACITE_METABO_PAT)
values('8115','Quebec','22','M','Quebec',1.11);

insert into TP_2_PATIENT
(NO_PATIENT, REGION_PAT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, INDICE_EFFICACITE_METABO_PAT)
values('8116','Métabetchouan-Lac-à-la-Croix','72','F','Quebec',0.71);

insert into TP_2_PATIENT
(NO_PATIENT, REGION_PAT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, INDICE_EFFICACITE_METABO_PAT)
values('8117','Yorkton-Melville','33','M','Saskatchewan',1.00);

insert into TP_2_PATIENT
(NO_PATIENT, REGION_PAT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, INDICE_EFFICACITE_METABO_PAT)
values('8118','Camrose-Drumheller','55','M','Alberta',0.97);

insert into TP_2_PATIENT
(NO_PATIENT, REGION_PAT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, INDICE_EFFICACITE_METABO_PAT)
values('8119','Thompson-Okanagan','42','F','Colombie-Britannique',1.23);


insert into TP_2_VARIATION_GENETIQUE
(NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSONE_VAR)
values('124565', 'A', 'C', ' UGT1A', '2');

insert into TP_2_VARIATION_GENETIQUE
(NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSONE_VAR)
values('124566', 'C', 'T', ' UGT2A', '19');

insert into TP_2_VARIATION_GENETIQUE
(NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSONE_VAR)
values('124567', 'G', 'G', ' UGT3A', '9');

insert into TP_2_VARIATION_GENETIQUE
(NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSONE_VAR)
values('124568', 'T', 'A', ' UGT4A', '7');

insert into TP_2_VARIATION_GENETIQUE
(NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSONE_VAR)
values('12459', 'C', 'T', ' CYP1B1', '2');


insert into TP_2_DROGUE 
(NO_DROGUE, NOM_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, TEMP_DEMI_VIE_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
values ('160', 'Cefmenoxime', 'C16H17N9O5S3', 'http://www.drugbank.ca/drugs/DB00267', '15', '25', '1','0.10','400');

insert into TP_2_DROGUE 
(NO_DROGUE, NOM_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, TEMP_DEMI_VIE_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
values ('161', 'Abacavir', 'C14H18N6O', 'http://www.drugbank.ca/drugs/DB01048', '200', '400', '0.5','0.03','200');

insert into TP_2_DROGUE 
(NO_DROGUE, NOM_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, TEMP_DEMI_VIE_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
values ('162', 'Biotin', 'C10H16N2O3', 'http://www.drugbank.ca/drugs/DB00121', '40', '75', '2','0.21','23');

insert into TP_2_DROGUE 
(NO_DROGUE, NOM_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, TEMP_DEMI_VIE_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
values ('163', 'Cassmoitioni', 'C12N2O38', 'http://www.drugbank.ca/drugs/DB001' , '450', '700', '0.1','0.01','375');

insert into TP_2_DROGUE 
(NO_DROGUE, NOM_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, TEMP_DEMI_VIE_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
values ('164', 'Gisofgody', 'NE10H1N6O9', 'http://www.drugbank.ca/drugs/DB0246', '1', '1.7', '0.02','0.003','10');


insert into TP_2_FABRICANT
(NO_DROGUE, NUM_FAB, NOM_FAB)
values('160','221','Les Roses');

insert into TP_2_FABRICANT
(NO_DROGUE, NUM_FAB, NOM_FAB)
values('161','222','Gesamtkunstwerk');

insert into TP_2_FABRICANT
(NO_DROGUE, NUM_FAB, NOM_FAB)
values('162','223','M.Drug');

insert into TP_2_FABRICANT
(NO_DROGUE, NUM_FAB, NOM_FAB)
values('163','224','Pillule inc');

insert into TP_2_FABRICANT
(NO_DROGUE, NUM_FAB, NOM_FAB)
values('164','223','M.Drug');


insert into TP_2_DROGUE_VARIANT
(NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME,
EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)
values('160','124565','Oui','Oui','Non','Non',1.21);

insert into TP_2_DROGUE_VARIANT
(NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME,
EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)
values('161','124566','Non','Non','Non','Non', 1);

insert into TP_2_DROGUE_VARIANT
(NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME,
EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)
values('162','124567','Oui','Non','Oui','Non', 0.92);

insert into TP_2_DROGUE_VARIANT
(NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME,
EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)
values('163','124568','Oui','Non','Non','Oui',1.08);

insert into TP_2_DROGUE_VARIANT
(NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME,
EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)
values('164','12459','Non','Non','Non','Oui', 0.45);

insert into TP_2_ETUDE
(NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)
values('745','15','160','124565','1235','','1995-06-07','1998-07-01','Anticoagulant');

insert into TP_2_ETUDE
(NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)
values('746','16','161','124566','1234','745','2001-04-21','2007-06-05','Les antioxidants');

insert into TP_2_ETUDE
(NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)
values('747','17','162','124567','1233','','2014-05-05','2016-02-02','La pneumonie');

insert into TP_2_ETUDE
(NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)
values('748','18','163','124568','1232','','1956-02-13','1970-03-10','La drogue pour les soigners tous');

insert into TP_2_ETUDE
(NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)
values('749','19','164','12459','1231','747','2000-01-03','2000-09-30','Les maladies pulmonaires MPOC');

insert into TP_2_ETUDE_PATIENT
(NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
values('745','1121','8115');

insert into TP_2_ETUDE_PATIENT
(NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
values('746','1221','8116');

insert into TP_2_ETUDE_PATIENT
(NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
values('747','1231','8117');

insert into TP_2_ETUDE_PATIENT
(NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
values('748','1421','8118');

insert into TP_2_ETUDE_PATIENT
(NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
values('749','2111','8119');


insert into TP_2_AUTEUR_ARTICLE 
(NO_ARTICLE, NUM_AUTEUR, AUTEUR)
values ('1231', '11', 'Aime Major' );

insert into TP_2_AUTEUR_ARTICLE 
(NO_ARTICLE, NUM_AUTEUR, AUTEUR)
values ('1232', '134', 'Renee Martel' );

insert into TP_2_AUTEUR_ARTICLE 
(NO_ARTICLE, NUM_AUTEUR, AUTEUR)
values ('1233', '12', 'Michel Louvain' );

insert into TP_2_AUTEUR_ARTICLE 
(NO_ARTICLE, NUM_AUTEUR, AUTEUR)
values ('1234', '231', 'Pierre Lalonde' );

insert into TP_2_AUTEUR_ARTICLE 
(NO_ARTICLE, NUM_AUTEUR, AUTEUR)
values ('1235', '321', 'Chantal Pary' );


-- 1 c              
delete from TP_2_DROGUE where COUT_DRO > 300;


--1 d
update TP_2_DROGUE set COUT_DRO = COUT_DRO * 1.15 where NO_DROGUE in 
  (select NO_DROGUE from TP_2_FABRICANT where NOM_FAB = 'GSK');

--1 e  
update TP_2_FABRICANT set NOM_FAB = 'Pfizer' where NO_DROGUE in 
  (select NO_DROGUE from TP_2_DROGUE where NOM_DRO = 'Acetasol') and NOM_FAB = 'Allergan';


--1 f
select B.NOM_CEN_RECHERCHE, V.NOM_DRO
  from (TP_2_CENTRE_DE_RECHERCHE B join ( TP_2_DROGUE V join TP_2_ETUDE O 
    on V.NO_DROGUE = O.NO_DROGUE) on O.NO_CEN_RECH = B.NO_CENTRE_RECHERCHE)
      where O.NO_ETUDE_PARENT is null order by NOM_CEN_RECHERCHE asc;

--1 g

----i)
SELECT TITRE_ART, NOM_REVUE_ART, DATE_ART, (
  SELECT WMSYS.WM_CONCAT(AUTEUR)
  FROM TP_2_AUTEUR_ARTICLE 
  WHERE  NO_ARTICLE IN (
    SELECT NO_ARTICLE 
    FROM TP_2_ETUDE
    WHERE NO_CEN_RECH = (
      SELECT NO_CENTRE_RECHERCHE
      FROM TP_2_CENTRE_DE_RECHERCHE
      WHERE NOM_CEN_RECHERCHE = 'Université Laval')))
    AS AUTEURS
FROM TP_2_ARTICLE article
WHERE  NO_ARTICLE IN (
  SELECT NO_ARTICLE 
  FROM TP_2_ETUDE
  WHERE NO_CEN_RECH = (
    SELECT NO_CENTRE_RECHERCHE
    FROM TP_2_CENTRE_DE_RECHERCHE
    WHERE NOM_CEN_RECHERCHE = 'Université Laval'));
          
----ii)
SELECT TITRE_ART, NOM_REVUE_ART, DATE_ART, (
  SELECT WMSYS.WM_CONCAT(AUTEUR)
  FROM TP_2_ARTICLE article 
    JOIN TP_2_ETUDE etude ON etude.NO_ARTICLE = article.NO_ARTICLE
    JOIN TP_2_AUTEUR_ARTICLE auteur ON article.NO_ARTICLE = auteur.NO_ARTICLE
  WHERE  NO_CEN_RECH = (
    SELECT NO_CENTRE_RECHERCHE 
    FROM TP_2_CENTRE_DE_RECHERCHE
    WHERE NOM_CEN_RECHERCHE = 'Université Laval'))
    AS AUTEURS
FROM TP_2_ARTICLE article 
  JOIN TP_2_ETUDE etude ON etude.NO_ARTICLE = article.NO_ARTICLE
WHERE  NO_CEN_RECH = (
  SELECT NO_CENTRE_RECHERCHE 
  FROM TP_2_CENTRE_DE_RECHERCHE
  WHERE NOM_CEN_RECHERCHE = 'Université Laval');

----iii)

SELECT TITRE_ART, NOM_REVUE_ART, DATE_ART, (
      SELECT WMSYS.WM_CONCAT(AUTEUR)
      FROM TP_2_AUTEUR_ARTICLE 
      WHERE EXISTS (
        SELECT NO_ARTICLE 
        FROM TP_2_ETUDE
        WHERE NO_CEN_RECH = (
          SELECT NO_CENTRE_RECHERCHE
          FROM TP_2_CENTRE_DE_RECHERCHE
          WHERE NOM_CEN_RECHERCHE = 'Université Laval')
        AND TP_2_AUTEUR_ARTICLE.NO_ARTICLE = NO_ARTICLE))
      AS AUTEURS
FROM TP_2_ARTICLE
WHERE EXISTS (
  SELECT NO_ARTICLE 
  FROM TP_2_ETUDE
  WHERE NO_CEN_RECH = (
    SELECT NO_CENTRE_RECHERCHE
    FROM TP_2_CENTRE_DE_RECHERCHE
    WHERE NOM_CEN_RECHERCHE = 'Université Laval')  
  AND TP_2_ARTICLE.NO_ARTICLE = NO_ARTICLE );

          
--1 h
select A.NUM_FAB, A.NOM_FAB, sum(C.COUT_DRO) as SUM_COUT_DRO, count(C.COUT_DRO) as NB_DRO, 
    max(C.COUT_DRO) as MAX_COUT_DRO, min(C.COUT_DRO) as MIN_COUT_DRO from 
      (TP_2_FABRICANT A join TP_2_DROGUE C on A.NO_DROGUE = C.NO_DROGUE) 
          group by A.NUM_FAB, A.NOM_FAB;     

-- 1 i
----i)

SELECT TITRE_ET
FROM TP_2_ETUDE
WHERE (NO_VAR_GEN, NO_DROGUE) NOT IN (
  SELECT NO_VAR_GEN, NO_DROGUE
  FROM TP_2_DROGUE_VARIANT
  WHERE EST_EFFET_AUTRE = 'Oui');
  
----ii)

SELECT TITRE_ET 
FROM TP_2_ETUDE
MINUS
SELECT TITRE_ET
FROM TP_2_ETUDE
WHERE (NO_VAR_GEN, NO_DROGUE) IN (
  SELECT NO_VAR_GEN, NO_DROGUE
  FROM TP_2_DROGUE_VARIANT
  WHERE EST_EFFET_AUTRE = 'Oui');
  
----iii)

SELECT TITRE_ET 
FROM TP_2_ETUDE
WHERE NOT EXISTS (
  SELECT NO_VAR_GEN, NO_DROGUE
  FROM TP_2_DROGUE_VARIANT
  WHERE EST_EFFET_AUTRE = 'Oui'  
  AND TP_2_ETUDE.NO_VAR_GEN = NO_VAR_GEN
  AND TP_2_ETUDE.NO_DROGUE = NO_DROGUE );

-- 1 j

SELECT NOM_DRO
FROM TP_2_DROGUE
WHERE EXISTS (
  SELECT NO_DROGUE
  FROM TP_2_ETUDE
  WHERE NO_DROGUE = TP_2_DROGUE.NO_DROGUE
    AND (SYSDATE - TO_DATE(DATE_DEBUT_ET, 'YYYY-MM-DD')) < 18*30 )
ORDER BY NOM_DRO;

--1 k

----i

CREATE OR REPLACE VIEW VUE_HIERARCHIE_ETUDE AS
SELECT LPAD(' ', (LEVEL-1)*2) || NO_ETUDE AS NO_ETUDE, NO_ETUDE_PARENT, NO_VAR_GEN, 
 (SELECT NOM_DRO
  FROM TP_2_DROGUE 
  WHERE TP_2_DROGUE.NO_DROGUE = TP_2_ETUDE.NO_DROGUE )
  AS NOM_DROGUE,
  
 (SELECT NOM_CEN_RECHERCHE
  FROM TP_2_CENTRE_DE_RECHERCHE
  WHERE TP_2_ETUDE.NO_CEN_RECH = TP_2_CENTRE_DE_RECHERCHE.NO_CENTRE_RECHERCHE)
  AS NOM_CENTRE_RECHERCHE
  
FROM TP_2_ETUDE
CONNECT BY PRIOR NO_ETUDE = NO_ETUDE_PARENT
START WITH NO_ETUDE in ( 
  SELECT NO_ETUDE 
  FROM TP_2_ETUDE 
  WHERE NO_ETUDE_PARENT IS NULL);

----ii
SELECT * FROM VUE_HIERARCHIE_ETUDE;

---- iii 
----(1)
--    Il est possible de faire cette opération dans oracle, par compte on doit respecter quelques
--    conditions. 

----(2)
--    Il est malheureusement impossible de le faire dans ce cas-ci puisqu'il contient un CONNECT BY.


--2 a 
/*
drop trigger TP_2_TRG_BI_VERIFIE_ET_PAT;
create or replace trigger TP_2_TRG_BI_VERIFIE_ET_PAT after
  insert on TP_2_ETUDE_PATIENT
  for each row
declare
  V_DATE date;
  V_DATE_DEBUT_ET date;
  V_DATE_FIN_ET date;
  V_PROVINCE_PAT varchar2(40);
  V_PROVINCE_CEN_RECH varchar2(40);
  V_NO_CEN_RECH varchar2(10);
  
  E_PROVINCE_DIFFERENTE exception;
  E_DATE_NON_EN_COURS exception;
begin
  select SYSDATE into V_DATE from dual;
  
  select DATE_DEBUT_ET into V_DATE_DEBUT_ET
    from TP_2_ETUDE 
    where TP_2_ETUDE.NO_ETUDE = :new.NO_ETUDE;
    
  select DATE_FIN_ET into V_DATE_FIN_ET
    from TP_2_ETUDE 
    where TP_2_ETUDE.NO_ETUDE = :new.NO_ETUDE;   
  
  select NO_CEN_RECH into V_NO_CEN_RECH 
    from TP_2_ETUDE where TP_2_ETUDE.NO_ETUDE = :new.NO_ETUDE;
  select PROVINCE_CEN_RECH into V_PROVINCE_CEN_RECH
    from TP_2_CENTRE_DE_RECHERCHE where NO_CENTRE_RECHERCHE = V_NO_CEN_RECH;
  select PROVINCE_PAT into V_PROVINCE_PAT
    from TP_2_PATIENT where NO_PATIENT = :new.NO_PATIENT;
  
    
  if V_PROVINCE_PAT != V_PROVINCE_CEN_RECH then
    raise E_PROVINCE_DIFFERENTE;
  end if;
    
  if V_DATE < V_DATE_DEBUT_ET or V_DATE > V_DATE_FIN_ET then
    raise E_DATE_NON_EN_COURS;
  end if;
exception
  
  when TOO_MANY_ROWS then
  raise_application_error(-20007, 'Trop de colonnes selectionnées');
  
  when E_DATE_NON_EN_COURS then
    raise_application_error(-20001,'La date d''aujourd''hui doit être entre la date de début et de fin.');
  
  when E_PROVINCE_DIFFERENTE then
    raise_application_error(-20006,'La province du centre de recherche n''est pas la même que celle du patient');
  
end;

delete from TP_2_ETUDE where NO_ETUDE = '111';
delete from TP_2_ETUDE_PATIENT where NO_ETUDE = '111';
*/
insert into TP_2_ETUDE (NO_ETUDE, NO_CEN_RECH, DATE_DEBUT_ET, DATE_FIN_ET) 
values ('111','17', to_date('2015-02-03','YYYY-MM-DD'), to_date('2016-03-30','YYYY-MM-DD'));

insert into TP_2_ETUDE_PATIENT (NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT) values ('111','1234','8115');





-- 2 b
/*
create or replace trigger TP_2_TRG_AU_VERIFIE_ETUDE after
  update on TP_2_ETUDE 
  for each row 
declare  
  E_CHAMPS_NON_MODIFIABLE exception;
  E_DATE_CONFLIT exception;
  
begin 
    
  if :old.NO_ETUDE != :new.NO_ETUDE or :old.NO_CEN_RECH != :new.NO_CEN_RECH or 
  :old.NO_DROGUE != :new.NO_DROGUE or :old.NO_VAR_GEN != :new.NO_VAR_GEN or
  :old.TITRE_ET != :new.TITRE_ET then
    raise E_CHAMPS_NON_MODIFIABLE;
  end if;
    
  if (:old.DATE_DEBUT_ET = :new.DATE_DEBUT_ET and :old.DATE_FIN_ET != :new.DATE_FIN_ET and :new.DATE_FIN_ET < :old.DATE_DEBUT_ET) or
    (:old.DATE_DEBUT_ET != :new.DATE_DEBUT_ET and :old.DATE_FIN_ET = :new.DATE_FIN_ET and :old.DATE_FIN_ET < :new.DATE_DEBUT_ET) or
    (:old.DATE_DEBUT_ET != :new.DATE_DEBUT_ET and :old.DATE_FIN_ET != :new.DATE_FIN_ET and :new.DATE_FIN_ET < :new.DATE_DEBUT_ET) then
      raise E_DATE_CONFLIT;
  end if;

exception
  when E_CHAMPS_NON_MODIFIABLE then
  raise_application_error(-20002,'Les champs que vous tentez de modifier ne sont pas modifiable');
  
  when TOO_MANY_ROWS then
  raise_application_error(-20005, 'Trop de colonnes selectionnées');
  
  when E_DATE_CONFLIT then
  raise_application_error(-20003, 'La date de début est après la date de fin');

end;

update TP_2_ETUDE set DATE_FIN_ET = to_date('2019-10-02', 'YYYY-MM-DD') where NO_ETUDE = 747;
*/
set serveroutput on;


-- 2 c
create or replace function FCT_INFO_DROGUE(P_I_NO_DROGUE in varchar2)
  return varchar2
is
  V_INFO_DROGUE varchar2(100);
begin
  select NOM_DRO || ' ' || URL_DRO into V_INFO_DROGUE
    from TP_2_DROGUE
    where NO_DROGUE = P_I_NO_DROGUE;
  return V_INFO_DROGUE;
end FCT_INFO_DROGUE;


-- test
select FCT_INFO_DROGUE(NO_DROGUE) from TP_2_DROGUE
where NO_DROGUE = '162';




-- 2 e

--Cette procédure trouve le prix avec taxe d'un numéro de drogue donné en paramètre.
create or replace procedure SP_COUT_TX_IN (P_I_NO_DROGUE varchar2) is V_COUT_DRO number(6,2);
  V_COUT_TX_IN number(6,2);
  V_NOM_DRO varchar2(15);
begin
  select NOM_DRO into V_NOM_DRO from TP_2_DROGUE where NO_DROGUE = P_I_NO_DROGUE;
  select to_number(COUT_DRO, '999') into V_COUT_DRO from TP_2_DROGUE where NO_DROGUE = P_I_NO_DROGUE;
  V_COUT_TX_IN := V_COUT_DRO * 1.15;
  dbms_output.put_line('Le prix avec de la drogue "' || V_NOM_DRO || '" est de ' || V_COUT_TX_IN || '$');
exception
  when NO_DATA_FOUND then
  dbms_output.put_line('Il n''y a pas de drogue numéro ' || P_I_NO_DROGUE);
end;

execute SP_COUT_TX_IN('164');



-- Fonction qui permet de mettre un rabais sur une certaine drogue.
create or replace function FCT_RABAIS_DRO(P_I_NO_DROGUE in varchar2, P_I_RABAIS_POURCENTAGE in number)
  return number is
  V_NEW_COUT_DRO number(8, 2);
begin
  select COUT_DRO into V_NEW_COUT_DRO
    from TP_2_DROGUE
    where NO_DROGUE = P_I_NO_DROGUE;
  if P_I_RABAIS_POURCENTAGE >= 0 and P_I_RABAIS_POURCENTAGE <= 100 then
    V_NEW_COUT_DRO := round(V_NEW_COUT_DRO * ((100 - P_I_RABAIS_POURCENTAGE) / 100), 2);
  else
     raise_application_error(-20004, 'Rabais invalide');
  end if; 
  return V_NEW_COUT_DRO;
end FCT_RABAIS_DRO;



--test
select FCT_RABAIS_DRO(NO_DROGUE, 10) from TP_2_DROGUE; 




-- On cree une fonction pour changer l'age des patients. On peux donc modifier l'age d'un patient plus facilement et ce meme si
-- nous avons oublier de le faire pendant plusieurs annees.
create or replace function FCT_NEW_AGE_PAT(P_I_NO_PATIENT in varchar2, P_I_AGE_ADDITIONNER in number)
return number is
V_NEW_AGE_PAT number(8,2);
begin
select AGE_PAT into V_NEW_AGE_PAT
from TP_2_PATIENT 
where NO_PATIENT = P_I_NO_PATIENT;
if P_I_AGE_ADDITIONNER >=0 and P_I_AGE_ADDITIONNER <= 100 then
V_NEW_AGE_PAT := round(V_NEW_AGE_PAT + P_I_AGE_ADDITIONNER, 2);
else 
raise_application_error(-20004, 'Age invalide, Veuillez entrer un nombre entre 0 et 100');
end if;
return V_NEW_AGE_PAT;
end FCT_NEW_AGE_PAT;


-- test
select FCT_NEW_AGE_PAT(NO_PATIENT, 2) from TP_2_PATIENT;


-- extra 

-- Fonction qui renvoie le ou les noms des l'auteurs pour un article donnee.
create or replace function FCT_INFO_ARTICLE(P_I_NO_ARTICLE in varchar2)
  return varchar2
is 
  V_INFO_ARTICLE varchar(200);
begin
select A.TITRE_ART || ' -- ' || B.AUTEUR into V_INFO_ARTICLE
from (TP_2_ARTICLE A join TP_2_AUTEUR_ARTICLE B on A.NO_ARTICLE = B.NO_ARTICLE)
where B.NO_ARTICLE = P_I_NO_ARTICLE and A.NO_ARTICLE = P_I_NO_ARTICLE;
return V_INFO_ARTICLE;
end FCT_INFO_ARTICLE;

--test
select FCT_INFO_ARTICLE(NO_ARTICLE) from TP_2_ARTICLE 
where NO_ARTICLE = '1232';



--3
---a)
----i)
CREATE UNIQUE INDEX IDX_NOM_DROGUE ON TP_2_DROGUE ( NOM_DRO ASC );
CREATE INDEX IDX_NO_DROGUE ON TP_2_ETUDE ( NO_DROGUE );
CREATE INDEX IDX_GENE_VAR ON TP_2_VARIATION_GENETIQUE (GENE_VAR);
CREATE INDEX IDX_NO_VARIANT_GEN ON TP_2_ETUDE ( NO_VAR_GEN );
CREATE UNIQUE INDEX IDX_TITRE_ARTICLE ON TP_2_ARTICLE (TITRE_ART ASC);
CREATE UNIQUE INDEX IDX_NO_ARTICLE ON TP_2_ETUDE (NO_ARTICLE);
CREATE INDEX IDX_AUTEUR_ARTICLE ON TP_2_AUTEUR_ARTICLE (AUTEUR);

--L'indexation ne fonctionne avec le mot clé LIKE que pour un patron au début de
--la chaîne, donc dans le cas d'un résumé d'article, les recherches peuvent se
--faire avec n'importe quelle partie de la chaîne, cela n'a aucun avantage.

----ii)
--On pourrait vouloir rechercher un centre de recherche par ville, par province,
--par nom.

CREATE UNIQUE INDEX IDX_NOM_CENTRE_RECH ON TP_2_CENTRE_DE_RECHERCHE (NOM_CEN_RECHERCHE ASC);
CREATE INDEX IDX_VILLE_CENTRE_RECH ON TP_2_CENTRE_DE_RECHERCHE (VILLE_CEN_RECH ASC);
CREATE INDEX IDX_PROVINCE_CENTRE_RECH ON TP_2_CENTRE_DE_RECHERCHE (PROVINCE_CEN_RECH ASC);
CREATE INDEX IDX_NO_CENTRE_RECH ON TP_2_ETUDE (NO_CEN_RECH);

---b)
----i)

--On peut éliminer une jointure en duplicant la masse moléculaire de la drogue dans la
--table drogue, ce qui aurait un faible impact au niveau de l'espace de stockage
--puisqu'il y a un nombre limité de différents nom pour une même molécule

--Pour éliminer les jointures lors de la recherche d'études, on pourrait dupliquer
--le nom de la drogue utilisée, puisque on est susceptible de faire une recherche
--par nom de drogue souvent.

----ii)
ALTER TABLE TP_2_ETUDE ADD NOM_DROGUE VARCHAR2(15) null;
UPDATE TP_2_ETUDE etude
  SET etude.NOM_DROGUE = ( SELECT drogue.NOM_DRO
                           FROM TP_2_DROGUE drogue
                           WHERE drogue.NO_DROGUE = etude.NO_DROGUE );
                           
ALTER TABLE TP_2_DROGUE ADD MASSE_MOL_DRO VARCHAR2(15) null;
UPDATE TP_2_DROGUE drogue
  SET drogue.MASSE_MOL_DRO = ( SELECT masse.MASSE_MOL_DRO
                               FROM TP_2_FORMULE_MASSE_DROGUE masse
                               WHERE masse.FORMULE_DROGUE = drogue.FORMULE_DROGUE );
                               
----iii)
/*
CREATE OR REPLACE TRIGGER TP_2_BU_DROGUE
  BEFORE INSERT OR UPDATE ON TP_2_DROGUE
  FOR EACH ROW
DECLARE
  V_MASSE VARCHAR2(15);
BEGIN
  SELECT MASSE_MOL_DRO INTO V_MASSE
  FROM TP_2_FORMULE_MASSE_DROGUE
  WHERE FORMULE_DROGUE = :new.FORMULE_DROGUE;
  :new.MASSE_MOL_DRO := V_MASSE;
END;
  
CREATE OR REPLACE TRIGGER TP_2_BU_ETUDE
  BEFORE INSERT OR UPDATE ON TP_2_ETUDE
  FOR EACH ROW
DECLARE
  V_NOM VARCHAR2(15);
BEGIN
  SELECT NOM_DRO INTO V_NOM
  FROM TP_2_DROGUE
  WHERE NO_DROGUE = :new.NO_DROGUE;
  :new.NOM_DROGUE := V_NOM;
END;

CREATE OR REPLACE PROCEDURE SP_ACTIVER_TRIGGER(TP_2_BU_DROGUE IN VARCHAR2) IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  EXECUTE IMMEDIATE 'alter trigger ' || TP_2_BU_DROGUE || ' enable';
END;

CREATE OR REPLACE PROCEDURE SP_ACTIVER_TRIGGER(TP_2_BU_ETUDE IN VARCHAR2) IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN 
  EXECUTE IMMEDIATE 'alter trigger ' || TP_2_BU_ETUDE || ' enable';
END;
*/
insert into TP_2_ETUDE
(NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)
values('750','17','162','124567','1233','','2014-05-05','2016-02-02','La drogue');

insert into TP_2_ETUDE_PATIENT (NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
values('747', '1234', '8116');

create or replace function TP3_FCT_AVG_INDICE_METABO(PI_NO_ETUDE TP_2_ETUDE_PATIENT.NO_ETUDE%type)
return number
is
    V_MOYENNE_INDICE_METABO TP_2_PATIENT.INDICE_EFFICACITE_METABO_PAT%type;
begin
    select avg(INDICE_EFFICACITE_METABO_PAT)
    into V_MOYENNE_INDICE_METABO
    from TP_2_PATIENT 
    where NO_PATIENT in(select NO_PATIENT from TP_2_ETUDE_PATIENT
                        where NO_ETUDE in(select NO_ETUDE from TP_2_ETUDE
                        where NO_ETUDE = PI_NO_ETUDE));
    return V_MOYENNE_INDICE_METABO;
end;


