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


inputnum=length(train_feature(:,1));       % �������Ԫ����
outputnum=length(train_label(:,1));      % �������Ԫ����
%% ���ݹ�һ��
[train_feature_deal,train_feature_format]=mapminmax(train_feature,0,1);
test_feature_deal=mapminmax('apply',test_feature,train_feature_format);
[train_label_deal,train_label_format]=mapminmax(train_label,0,1);

%% ��ʼ����BP����
net=newff(train_feature_deal,train_label_deal,{hiddennum1,hiddennum2,hiddennum4});              
%�趨�����������
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
%% BP�������ʼȨֵ����ֵ
% w1num=inputnum*hiddennum;                                           %����㵽�����Ȩֵ����
% w2num=outputnum*hiddennum;                                          %�����㵽������Ȩֵ����                %�漴����Ȩֵ
% W1=x(1:w1num);                                                      %��ʼ����㵽�������Ȩֵ
% B1=x(w1num+1:w1num+hiddennum);                                      %������Ԫ��ֵ
% W2=x(w1num+hiddennum+1:w1num+hiddennum+w2num);                      %�����㵽������Ȩֵ
% B2=x(w1num+hiddennum+w2num+1:w1num+hiddennum+w2num+outputnum);      %�������ֵ
% net.iw{1,1}=reshape(W1,hiddennum,inputnum);                         %Ϊ�����������㵽������Ȩֵ��ֵ
% net.lw{2,1}=reshape(W2,outputnum,hiddennum);                        %Ϊ������������㵽�����Ȩֵ��ֵ
% net.b{1}=reshape(B1,hiddennum,1);                                   %Ϊ�������������Ԫ��ֵ��ֵ
% net.b{2}=reshape(B2,outputnum,1);                                   %Ϊ��������������ֵ��ֵ
%% ��ʼѵ��
net = train(net,train_feature_deal,train_label_deal);
net.trainParam.epochs=500;
%% ��������
% solution=[57,2,3,1,1,1,2,1,8,10,10];
% test_solution=mapminmax('apply',solution,train_feature_format);
% so=sim(net,test_solution);
% bpso = mapminmax('reverse',so,train_label_format);  

t_sim = sim(net,test_feature_deal);                                 %������������������
T_sim = mapminmax('reverse',t_sim,train_label_format);              %����һ��

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