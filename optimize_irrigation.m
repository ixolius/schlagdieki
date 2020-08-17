path(path,'.\Skripts');
global LOG c09len;
water=300;  %Unit [mm]


%%%%%%%%%%%%%%%%%%%%%do not change below%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=water/10;
mindt =10;
dt=5+floor(5*(45-x)/(45-15));
dw=1500-floor(1000*(45-x)/(45-15));
lai=[];
element=[];
watervol=x*1000;
wboptim; %Optimization
best=find(lai==max(lai));
best=best(1);
LOG=[LOG; max(lai) element(best,:)/1000];
%% Best scenario
command=['!perl write_schedule_aquacrop.pl ' num2str(10*element(best,:)/1000)];
eval(command);
command=['!perl calc_aquacrop.pl'];
eval(command);
eval('!perl cut_head.pl ACsaV40/OUTP/KonstantPRO.OUT');
result=load('result.txt',' -ascii ');
[yield,id]=max(result(:,30)); %Column 4 is yield
%%save the result
save snapshot.mat LOG;
disp(['FINISH -- HIGHEST YIELD IS ',num2str(yield),' FOR ',num2str(x*10),'mm of irrigation']);
disp (['Schedule is: ', num2str(10*element(best,:)/1000)]);
