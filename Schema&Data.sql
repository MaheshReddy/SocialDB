drop table cseteam51.userPreference;
drop table cseteam51.userPasswd;
drop table cseteam51.userinfo;
drop table cseteam51.circle;
drop table cseteam51.circleMember;
drop table cseteam51.sip;
drop table cseteam51.sipmember;
drop table cseteam51.page;
drop table cseteam51.post;
drop table cseteam51.comment;
drop table cseteam51.message;
drop table cseteam51.msgReciever;
drop table cseteam51.advt;
drop table cseteam51.sale;
drop table cseteam51.friendRequest;
drop table cseteam51.friend;


create table cseteam51.page(
pageId varchar(20) NOT NULL,
primary key(pageId)
);

create TABLE cseteam51.userinfo(
ID  varchar(20) PRIMARY KEY NOT NULL, 
fName varchar(20) NOT NULL,
lName varchar(20) NOT NULL,
Sex char(2) NOT NULL,
EmailID varchar(40) NOT NULL,
DOB date NOT NULL, 
Address varchar(100) NOT NULL, 
City varchar(20) NOT NULL,
State varchar(10) NOT NULL,
ZipCode varchar(10) NOT NULL,
Telephone varchar(15) NOT NULL,
wallid varchar(20) NOT NULL,
UNIQUE (EmailID),
foreign key(wallid) references cseteam51.page,
unique(wallid)
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

create table cseteam51.friendRequest(
fromUsrId varchar(20) NOT NULL,
toUsrId varchar(20) NOT NULL,
primary key(fromUsrId,toUsrId),
foreign key(fromUsrID) references cseteam51.userinfo(id),
foreign key(toUsrID) references cseteam51.userinfo(id)
);

create table cseteam51.friend(
usrid1 varchar(20) NOT NULL,
usrid2 varchar(20) NOT NULL,
primary key(usrid1,usrid2),
foreign key(usrid1) references cseteam51.userinfo(id),
foreign key(usrid2) references cseteam51.userinfo(id)
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
sipPageId varchar(20) NOT NULL,
primary key(sipid),
unique(sipName),
foreign key(sipPageId) references page(pageid),
unique(sipPageId)
);


create table cseteam51.sipMember(
sipId varchar(20) NOT NULL,
memberId varchar(20) NOT NULL,
moderator varchar(1),
primary key(sipId,memberId),
foreign key(memberID) references cseteam51.userinfo(id),
foreign key(sipid) references cseteam51.sip
);


create table cseteam51.post(
postid varchar(20) NOT NULL,
postDate date NOT NULL,
postTime time not NULL,
timeZone varchar(10) NOT NULL,
content varchar(500) not NULL,
author varchar(20) NOT NULL,
pageid varchar(20) NOT NULL,
primary key(postid),
foreign key(author) references cseteam51.userinfo(id),
foreign key(pageid) references cseteam51.page
);

create table cseteam51.comment(
commentId varchar(20) NOT NULL,
commentDate date NOT NULL,
commentTime time not null,
timezone varchar(10) NOT NULL,
content varchar(100) NOT NULL,
authorId varchar(20) not null,
postid varchar(20) not null,
primary key(commentId),
foreign key(authorid) references cseteam51.userinfo(id),
foreign key(postid) references cseteam51.post
);

create table cseteam51.message(
mesgId varchar(20) NOT NULL,
mesgDate date NOT NULL,
subject varchar(20) NOT NULL,
contents varchar(200) NOT NULL,
sender varchar(20) NOT NULL,
primary key(mesgId),
foreign key(sender) references cseteam51.userinfo(id)
);

create table cseteam51.msgReciever(
mesgId varchar(20) NOT NULL,
recvId varchar(20) NOT NULL,
primary key(mesgid,recvid),
foreign key(mesgid) references cseteam51.message,
foreign key(recvid) references cseteam51.userinfo(id)
);

create table cseteam51.advt (
advtId varchar(20) NOT NULL,
type varchar(20) NOT NULL,
advtDate date NOT NULL,
company varchar(20) NOT NULL,
itemName varchar(20) NOT NULL,
unitPrice float not null,
noUnits integer not null,
primary key (advtId)
);

create table cseteam51.sale (
transId varchar(20) NOT NULL,
saleDate date NOT NULL,
advtId varchar(20) NOT NULL,
noUnits integer not null,
userId varchar(20) not null,
primary key(transid),
foreign key(advtId) references cseteam51.advt,
foreign key(userId) references cseteam51.userinfo(id)
);

insert into cseteam51.page values ('2001');
insert into cseteam51.page values ('2002');
insert into cseteam51.page values ('2003');
insert into cseteam51.page values ('2004');
insert into cseteam51.page values ('2005');
insert into cseteam51.page values ('2006');
insert into cseteam51.page values ('2007');
insert into cseteam51.page values ('2008');



insert into USERINFO values
('100100101', 'Alice', 'McKeeny', 'F', 'alice@blah.com' ,'1988-10-10', 
'Chapin Apt 2010,Health Drive','Stony Brook', 'NY' ,'11790', '4314649881','2001');
insert into USERINFO values
('100100102', 'Bob', 'Wonderwall', 'M', 'bob@blah.com' ,'1988-8-6', 
'21 MajorApt,Oak St','NewYork', 'NY' ,'11700', '4314649882','2002');
insert into USERINFO values
('100100103', 'Elisa', 'Roth', 'F', 'elisa@blah.com' ,'1992-11-10', 
'43 Corvette Apt,Maple St','Stony Brook', 'NY' ,'11790', '4314649883','2003');
insert into USERINFO values
('100100104', 'Kelly', 'Mcdonald', 'F', 'kelly@blah.com' ,'1991-12-11', 
'54 East Apt,Oak St','Newyork', 'NY' ,'11700', '4314649884','2004');
insert into USERINFO values
('100100105', 'Wendy', 'Stanley', 'F', 'wendy@blah.com' ,'1992-8-8', 
'MajorApt,Oak St.','Stony Brook', 'NY' ,'11790', '4314649885','2005');
insert into USERINFO values
('100100106', 'Dennis', 'Ritche', 'M', 'den@blah.com' ,'1992-2-3', 
'43 Corvette Apt, Maple St','NewYork', 'NY' ,'11790', '4314649886','2006');

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


insert into sip values ('1001','CSE532','2007');

insert into sipMember values ('1001','100100101','t');
insert into sipMember values ('1001','100100102','f');
insert into sipMember values ('1001','100100103','f');

insert into cseteam51.post values ('20111','2012-10-10','17:00','EST','Its Snowing!:D','100100105','2007');
insert into cseteam51.post values ('20112','2012-10-11','17:00','EST','GO Seawolves!!!!','100100106','2007');
insert into cseteam51.post values ('20113','2012-10-11','17:00','EST','Hi First post on you wall','100100106','2001');


insert into cseteam51.comment values ('900001','2012-10-10','17:01','EST','Its beautiful! :)','100100101','20111');
insert into cseteam51.comment values ('900002','2012-10-10','17:02','EST','Natures white blanket :D','100100106','20111');

insert into cseteam51.message values ('3001','2012-10-10','CSE532','Do u have assignent 1 questions?','100100101');
insert into cseteam51.message values ('3002','2012-10-10','re: CSE532','nope. I think patrick has them.','100100102');
insert into cseteam51.msgReciever values ('3001','100100102');
insert into cseteam51.msgReciever values ('3001','100100103');
insert into cseteam51.msgReciever values ('3002','100100101');
insert into cseteam51.msgReciever values ('3001','100100101');
insert into cseteam51.msgReciever values ('3002','100100102');

insert into cseteam51.advt values ('33331','car','2012-04-10','ford','2012-Mustang','22000','30');
insert into cseteam51.advt values ('33332','clothing','2012-04-10','GAP','Superman Shirt','5','100');
insert into cseteam51.advt values ('33333','car','2012-04-10','ford','2011-Mustang','32000','20');

insert into cseteam51.sale values ('200010001','2012-04-22','33331','2','100100101');
insert into cseteam51.sale values ('200010002','2012-04-22','33332','2','100100101');
insert into cseteam51.sale values ('200010004','2012-04-22','33333','1','100100101');
insert into cseteam51.sale values ('200010005','2012-04-22','33331','2','100100102');

insert into friend values ('100100101','100100102');
insert into friend values ('100100101','100100103');
insert into friend values ('100100102','100100101');
insert into friend values ('100100103','100100101');

