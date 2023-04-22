tic
% 灰狼优化算法（求函数极值）
% clc;
% clear;
% close all;
%% 目标函数
% figure(1);
% fplot(f, [0 20], 'b-');                 % 画出初始图像 
% title('初始图像');
% hold on;
%% 初始化参数
N=1000;       % 灰狼个数
dim=10;      % 维度
Iter=1000;   % 最大迭代次数
a=2;        % 收敛因子
ub=65;      % 最大值限制
lb=1;       % 最小值限制
d_lim=2;
se_lim=2.5e4;
 
% 初始化alpha,beta,delta
Alpha_pos=zeros(1,dim);    
Alpha_score=inf; %求最大值改为inf
Beta_pos=zeros(1,dim);
Beta_score=inf; 
Delta_pos=zeros(1,dim);
Delta_score=inf;
 
Positions=rand(N,dim).*(ub-lb)+lb;      % 初始化个体位置
Convergence_curve=zeros(1,Iter);        % 收敛曲线
l=0;        %循环次数记录
pos_history=[];
cal_curve=[];
%% 迭代求解
while l<Iter
    for i=1:size(Positions,1)  
        
       % 超出边界处理
        Positions = round(Positions);
        Positions = max(Positions,lb);
        Positions = min(Positions,ub);         
        
        % 计算个体适应度函数
        fitness=Sphere(Positions(i,:));
        
        % 更新 Alpha, Beta, and Delta
        if fitness<Alpha_score 
            d = abs(displacement(Positions(i,:)));
            se = abs(stress(Positions(i,:)));
            cal_curve=[cal_curve;Alpha_score];
            if d<=d_lim&&se<=se_lim
                Alpha_score=fitness; 
                Alpha_pos=Positions(i,:);
                pos_history=[pos_history;Alpha_pos];
            end
        end    
        if fitness>Alpha_score && fitness<Beta_score 
            d = abs(displacement(Positions(i,:)));
            se = abs(stress(Positions(i,:)));
            cal_curve=[cal_curve;Alpha_score];
            if d<=d_lim&&se<=se_lim
                Beta_score=fitness; 
                Beta_pos=Positions(i,:);
                pos_history=[pos_history;Beta_pos];
            end
        end     
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 
            d = abs(displacement(Positions(i,:)));
            se = abs(stress(Positions(i,:)));
            cal_curve=[cal_curve;Alpha_score];
            if d<=d_lim&&se<=se_lim
                Delta_score=fitness; 
                Delta_pos=Positions(i,:);
                pos_history=[pos_history;Delta_pos];
            end
        end
    end
       
    a=2-l*((2)/Iter); % 收敛因子从2线性递减到0
    
    % 更新灰狼个体的位置
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
            
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]   
            A1=2*a*r1-a;
            C1=2*r2;
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j)); 
            X1=Alpha_pos(j)-A1*D_alpha;
                       
            r1=rand();
            r2=rand();          
            A2=2*a*r1-a;
            C2=2*r2;       
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j));
            X2=Beta_pos(j)-A2*D_beta;
            
            r1=rand();
            r2=rand();          
            A3=2*a*r1-a; 
            C3=2*r2;          
            D_delta=abs(C3*Delta_pos(j)-Positions(i,j));
            X3=Delta_pos(j)-A3*D_delta;
            
            Positions(i,j)=(X1+X2+X3)/3;% Equation (3.7)         
        end
    end
    l=l+1;    
    Convergence_curve(l)=Alpha_score;
    disp(['Iteration ' num2str(l) ': Best Cost = ' num2str(Alpha_score)]);
end
% plot(Alpha_pos, f(Alpha_pos), '*r');
 
% figure(2);
% plot(Convergence_curve);
% title('收敛过程'); 
 
display(['The best solution obtained by GWO is : ', num2str(Alpha_pos)]);
display(['The best optimal value of the objective funciton found by GWO is : ', num2str(Alpha_score)]);
toc
