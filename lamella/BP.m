profile on 
%load data.txt   -ASCII
train_feature=data(1:4000,1:29)';
train_label=abs(data(1:4000,30))';
test_feature=data(4001:4800,1:29)';
test_label=abs(data(4001:4800,30))'; 
% 

% label=max(abs(result(:,13)),abs(result(:,14)));      
% train_label=label(1:9000,1)';
% test_label=label(9001:10000,1)';

hiddennum1 = 50;
hiddennum2 = 30;
hiddennum3 = 10;
hiddennum4 = 5;


inputnum=length(train_feature(:,1));       % 输入层神经元个数
outputnum=length(train_label(:,1));      % 输出层神经元个数
%% 数据归一化
[train_feature_deal,train_feature_format]=mapminmax(train_feature,0,1);
test_feature_deal=mapminmax('apply',test_feature,train_feature_format);
[train_label_deal,train_label_format]=mapminmax(train_label,0,1);

%% 开始构建BP网络
net=newff(train_feature_deal,train_label_deal,{hiddennum1,hiddennum2,hiddennum4});              
%设定参数网络参数
net.trainParam.epochs=500;
net.trainParam.goal=1e-15;
net.trainParam.lr=0.01;
net.trainParam.showwindow=true;
net.divideFcn = '';
% net.divideFcn= 'dividerand'; % divide the data randomly
% net.divideParam.trainRatio= 0.7; % we use 70% of the data for training
% net.divideParam.valRatio= 0.15; % 30% is for validation
% net.divideParam.testRatio= 0.15; 

net.trainFcn = 'trainlm';
%net.performFcn='crossentropy';
%net.performFcn='mae';
%net.performFcn='sae';
%net.performFcn='sse';
%% BP神经网络初始权值和阈值
% w1num=inputnum*hiddennum;                                           %输入层到隐层的权值个数
% w2num=outputnum*hiddennum;                                          %隐含层到输出层的权值个数                %随即生成权值
% W1=x(1:w1num);                                                      %初始输入层到隐含层的权值
% B1=x(w1num+1:w1num+hiddennum);                                      %隐层神经元阈值
% W2=x(w1num+hiddennum+1:w1num+hiddennum+w2num);                      %隐含层到输出层的权值
% B2=x(w1num+hiddennum+w2num+1:w1num+hiddennum+w2num+outputnum);      %输出层阈值
% net.iw{1,1}=reshape(W1,hiddennum,inputnum);                         %为神经网络的输入层到隐含层权值赋值
% net.lw{2,1}=reshape(W2,outputnum,hiddennum);                        %为神经网络的隐含层到输出层权值赋值
% net.b{1}=reshape(B1,hiddennum,1);                                   %为神经网络的隐层神经元阈值赋值
% net.b{2}=reshape(B2,outputnum,1);                                   %为神经网络的输出层阈值赋值
%% 开始训练
net = train(net,train_feature_deal,train_label_deal);
net.trainParam.epochs=500;
%% 测试网络
% solution=[57,2,3,1,1,1,2,1,8,10,10];
% test_solution=mapminmax('apply',solution,train_feature_format);
% so=sim(net,test_solution);
% bpso = mapminmax('reverse',so,train_label_format);  

t_sim = sim(net,test_feature_deal);                                 %将测试特征输入网络
T_sim = mapminmax('reverse',t_sim,train_label_format);              %反归一化

mse_net = mse(T_sim-test_label);   
err=abs((T_sim-test_label)./test_label);
err_ave=sum(err)/length(err);

con=[test_label;T_sim]';
%save('bp_displacment.mat','net','train_feature_format','train_label_format');
%save('bp_stress.mat','net','train_feature_format','train_label_format');
%save('bp_stability.mat','net','train_feature_format','train_label_format');

% w1=reshape(net.iw{1,1},hiddennum*inputnum,1);
% w2=reshape(net.lw{2,1},hiddennum*outputnum,1);
% b1=reshape(net.b{1},hiddennum,1);
% b2=reshape(net.b{2},outputnum,1);
% x=[w1;b1;w2;b2]';
% save paras_BP.txt x -ASCII
% profile off
%profile viewer