unit esit;
interface
uses dos;
var
lvv : string;
type
annet = array[24..300] of byte;
esat = array[24..300]of byte;
enttiilit = array[24..300]of byte;
var
kannet : ^annet;
pesat : ^esat;
venttiilit : ^enttiilit;
type
aara1 = array[1..20] of byte;
aara2 = array[1..20] of byte;
aara3 = array[1..20] of byte;
aara4 = array[1..20] of byte;
aara5 = array[1..20] of byte;
oot1  = array[1..20] of string;
oot2 =  array[1..20] of string;
oot3 = array[1..20] of string;
oot4 = array[1..20] of string;
oot5 = array[1..20] of string;
ot1  = array[1..20] of integer;
ot2 = array[1..20] of integer;
ot3 = array[1..20] of integer;
ot4 = array[1..20] of integer;
ot5 = array[1..20] of integer;
os1 = array [1.. 300] of string[6];
os2 =  array[1.. 300] of string[6];
os3 =  array[1.. 300] of string[6];
os4 =  array[1.. 300] of string[6];
os5 =  array[1.. 300] of string[6];
o1 =  array[1.. 300] of real;
o2 =  array[1.. 300] of real;
o3 =  array[1.. 300] of real;
o4 =  array[1.. 300] of real;
o5 =  array[1.. 300] of real;
bps1 =  array[1.. 300] of real;
bps2 =  array[1.. 300] of real;
bps3 =  array[1.. 300] of real;
bps4 =  array[1.. 300] of real;
bps5 =  array[1.. 300] of real;
var
vast : string;
monta : array[1..6] of integer;
lisa : array [1..15] of string;
lisaa : array[1..15] of integer;
paivia : array[1..20] of string;
summa1,summa : real;
maara1 : ^aara1;
maara2 : ^aara2;
maara3 : ^aara3;
maara4 : ^aara4;
maara5 : ^aara5;
koot1 : ^oot1;
koot2 : ^oot2;
koot3 : ^oot3;
koot4 : ^oot4;
koot5 : ^oot5;
kot1 : ^ot1;
kot2 : ^ot2;
kot3 : ^ot3;
kot4 : ^ot4;
kot5 : ^ot5;
pos1 : ^os1;
pos2 : ^os2;
pos3 : ^os3;
pos4 : ^os4;
pos5 : ^os5;
s1 : ^o1;
s2 : ^o2;
s3 : ^o3;
s4 : ^o4;
s5 : ^o5;
bpos1 : ^bps1;
bpos2 : ^bps2;
bpos3 : ^bps3;
bpos4 : ^bps4;
bpos5 : ^bps5;
const
koot : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
var
p1 : boolean;
p2 : boolean;
p3 : boolean;
p4 : boolean;
p5 : boolean;
hae : searchrec;
d,f,vara,koko,b,c,a,vuosi3,paiva3,maara,kuu3,vuosi,kuu,paiva,vko,vuosi4,kuu4,paiva4,vko4 : word;
lvv1,x,x1,x2,x3,x4,x5 : integer;
e : real;
nappain,NAPPAIN1 : char;
totuus : boolean;
a1,b1,osa,osa1,koko1,osa2,osa3,s,vuosi2,kuu2,paiva1,paiva2,paivays : string;
luku : text;
implementation
begin
new(pos1);
new(pos2);
new(pos3);
new(pos4);
new(pos5);
new(bpos1);
new(bpos2);
new(bpos3);
new(bpos4);
new(bpos5);
new(s1);
new(s2);
new(s3);
new(s4);
new(s5);
new(maara1);
new(maara2);
new(maara3);
new(maara4);
new(maara5);
new(koot1);
new(pesat);
new(kannet);
new(venttiilit);
new(koot2);
new(koot3);
new(koot4);
new(koot5);
new(kot1);
new(kot2);
new(kot3);
new(kot4);
new(kot5);
end.