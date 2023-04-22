tic
data=[];
for loop=1:10000
    x=unidrnd(34,1,29);
    [d,se,sa]=ansysfem(x);
    if d==1e10 && se==1e10 && sa==1e10
        disp('pass')
    else
        data=[data;x,d,se,sa];
    end
    break
end
t=toc;
save data.txt data -ASCII


%x=[8,4,3,10,10,12];
%[d,se,sa]=ansysfem(x);
