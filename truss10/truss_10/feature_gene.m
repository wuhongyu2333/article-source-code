feature=unidrnd(65,5000,10)
save feature.txt feature -ASCII
load result.txt
t=result(:,1:10)
a=unique(t,'row')