tic
data=[];
for loop=1:8000
    h=0.25*unidrnd(61)+4.75;
    m=unidrnd(13,1,2)+2;
    g=unidrnd(34,1,3);
    x=[h,m,g];
    [d,se,sa]=ansysfem(x);
    if d==1e10 && se==1e10 && sa==1e10
        disp('pass')
    else
        data=[data;x,d,se,sa];
    end
end
toc
save data.txt data -ASCII


%x=[8,4,3,10,10,12];
%[d,se,sa]=ansysfem(x);
