program fact;
uses crt;
const max = 1000;

var
   c : array[1..max] of longint;
   a,blanc : packed array[1..6] of char;
   s : string[80];
   n : longint;
   err : integer;

{============================= F ===========================}

function f(n:longint) : longint;
begin
f:=trunc(trunc((ln(n)*(n+0.5)-n+0.5*ln(2*pi))/ln(10))/6)+1;
end;

{============================= DD ===========================}

function dd(k:longint) : longint;
begin
end;

{========================== CALC_FACT =======================}

procedure calc_fact(n:longint);

var
   fx,i,r,j,m,z,t : longint;
   mr,x : real;

procedure affiche_fact;

var
   g,d,i : longint;

begin
clrscr;
g := 0;
d := 5 - trunc(ln(c[fx])/ln(10));
write(copy(blanc,1,d),c[fx]);

for i:=fx-1 downto 1 do
    begin
    g:=g+6;
    if g mod 78 = 0 then
       writeln;
    if g >= 1794 then
       begin
       writeln;
       g:=0;
       write('Pour continuer pressez Entr‚e');
       readln(s);
       clrscr;
       end;

        if (c[i] <> 0) or (z <> 0) then
           begin
           z := 1;
           if c[i] = 0 then
              write(a)
           else
               begin
               d := 5 - trunc(ln(c[i])/ln(10));
               write(copy(a,1,d),c[i]);
               end;
           end;

    end;

if fx > 1 then
    begin
    end;

writeln;

end;

begin
fx := f(n);
c[1] := 1;
for i:=2 to fx do c[i]:=0;
r:=0;
j:=0;
z:=0;

for m:=2 to n do
    begin
    fx:=f(m);
    for i:=1 to fx do
        begin
        t:=c[i];
        x := (m*t+r)/1000000.0;
        c[i]:=trunc((x-int(x))*1000000+0.05);
        r:=trunc(x);
        end;
    if m mod 10 = 0 then write (m,'/');
    end;

affiche_fact;
end;

{============================ MAIN ==========================}
begin

a := '000000';
blanc := '      ';

clrscr;

repeat

writeln;

repeat

err := 0;

write('Donner le nombre dont on doit calculer la factorielle: ');
readln(s);
if s = '' then
   n:=-1
else
    val(s,n,err);

until err=0;


case n of

   0,1: begin
             clrscr;
             writeln(n,' ! est ‚gale … 1');
        end;

   -1 :

   else
       calc_fact(n);

end;

until (n < 0);

end.