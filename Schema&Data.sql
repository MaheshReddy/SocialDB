drop table cseteam51.userPreference;

drop table cseteam51.userPasswd;

drop table cseteam51.userinfo;

drop table cseteam51.circle;

drop table cseteam51.circleMember;

create TABLE cseteam51.userinfo(
ID  varchar(20) PRIMARY KEY NOT NULL, 
FirstName varchar(20) NOT NULL,
LastName varchar(20) NOT NULL,
Sex char(2) NOT NULL,
EmailID varchar(40) NOT NULL,
DOB date NOT NULL, 
Address varchar(100) NOT NULL, 
City varchar(20) NOT NULL,
State varchar(10) NOT NULL,
ZipCode varchar(10) NOT NULL,
Telephone varchar(15) NOT NULL,
UNIQUE (EmailID)
);

create TABLE cseteam51.userPasswd(
userid varchar(20) PRIMARY KEY NOT NULL,
passwd varchar(30) NOT NULL,
email varchar(20) NOT NULL,
UNIQUE (email),
FOREIGN	KEY (userid) references cseteam51.userinfo(ID),
FOREIGN	KEY (email) references cseteam51.userinfo(emailid)
);

create table cseteam51.userPreference(
userid varchar(20) NOT NULL,
preference varchar(15) NOT NULL,
PRIMARY KEY(userid,preference),
foreign key(userid) references cseteam51.userinfo(ID)
);

create table cseteam51.circle(
circleId varchar(20) NOT NULL,
circleName varchar(20) NOT NULL,
ownerId varchar(20) NOT NULL,
primary key(circleId),
foreign key(ownerID) references cseteam51.userinfo(id)
);

create table cseteam51.circleMember(
circleId varchar(20) NOT NULL,
memberId varchar(20) NOT NULL,
foreign key(circleId) references cseteam51.circle,
foreign key(memberId) references cseteam51.userinfo(id),
primary key(circleid,memberid)
);

create table cseteam51.sip(
sipId varchar(20) NOT NULL,
sipName varchar(20) NOT NULL,
primary key(sipid),
unique(sipName)
);

create table cseteam51.sipMembers(
sipId varchar(20) NOT NULL,
memberId varchar(20) NOT NULL,
moderator boolean,
primary key(sipId,memberId),
foreign key(memberID) references cseteam51.userinfo(id),
foreign key(sipid) references cseteam51.sip
);

insert into USERINFO values
('100100101', 'Alice', 'McKeeny', 'F', 'alice@blah.com' ,'1988-10-10', 
'Chapin Apt 2010,Health Drive','Stony Brook', 'NY' ,'11790', '4314649881');
insert into USERINFO values
('100100102', 'Bob', 'Wonderwall', 'M', 'bob@blah.com' ,'1988-8-6', 
'21 MajorApt,Oak St','NewYork', 'NY' ,'11700', '4314649882');
insert into USERINFO values
('100100103', 'Elisa', 'Roth', 'F', 'elisa@blah.com' ,'1992-11-10', 
'43 Corvette Apt,Maple St','Stony Brook', 'NY' ,'11790', '4314649883');
insert into USERINFO values
('100100104', 'Kelly', 'Mcdonald', 'F', 'kelly@blah.com' ,'1991-12-11', 
'54 East Apt,Oak St','Newyork', 'NY' ,'11700', '4314649884');
insert into USERINFO values
('100100105', 'Wendy', 'Stanley', 'F', 'wendy@blah.com' ,'1992-8-8', 
'MajorApt,Oak St.','Stony Brook', 'NY' ,'11790', '4314649885');
insert into USERINFO values
('100100106', 'Dennis', 'Ritche', 'M', 'den@blah.com' ,'1992-2-3', 
'43 Corvette Apt, Maple St','NewYork', 'NY' ,'11790', '4314649886');

insert into USERPASSWD values
('100100101','alice','alice@blah.com');
insert into USERPASSWD values
('100100102','bob','bob@blah.com');
insert into USERPASSWD values
('100100103','elisa','elisa@blah.com');
insert into USERPASSWD values
('100100104','kelly','kelly@blah.com');
insert into USERPASSWD values
('100100105','wendy','wendy@blah.com');
insert into USERPASSWD values
('100100106','den','den@blah.com');

insert into userPreference values ('100100101','car');
insert into userPreference values ('100100101','life');
insert into userPreference values ('100100101','insurance');
insert into userPreference values ('100100102','car');
insert into userPreference values ('100100102','clothing');
insert into userPreference values ('100100103','clothing');
insert into userPreference values ('100100104','clothing');
insert into userPreference values ('100100104','toys');
insert into userPreference values ('100100105','life insurance');
insert into userPreference values ('100100106','life insurance');


insert into circle values ('8001','cse532','100100101');
insert into circle values ('8002','My family','100100101');


insert into circleMember values ('8001','100100102');
insert into circleMember values ('8001','100100103');
insert into circleMember values ('8001','100100104');
insert into circleMember values ('8002','100100104');
insert into circleMember values ('8002','100100105');
insert into circleMember values ('8002','100100106');
