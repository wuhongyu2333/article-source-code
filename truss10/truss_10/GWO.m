% �����Ż��㷨��������ֵ��
clc;
clear;
close all;
%% Ŀ�꺯��
f= @(x) sum(x.^2); % ��Ӧ�Ⱥ������ʽ(��������������ֵ)  
% figure(1);
% fplot(f, [0 20], 'b-');                 % ������ʼͼ�� 
% title('��ʼͼ��');
hold on;
%% ��ʼ������
N=100;       % ���Ǹ���
dim=30;      % ά��
Iter=1000;   % ����������
a=2;        % ��������
ub=100;      % ���ֵ����
lb=-100;       % ��Сֵ����
 
% ��ʼ��alpha,beta,delta
Alpha_pos=zeros(1,dim);    
Alpha_score=inf; %�����ֵ��Ϊinf
Beta_pos=zeros(1,dim);
Beta_score=inf; 
Delta_pos=zeros(1,dim);
Delta_score=inf;
 
Positions=rand(N,dim).*(ub-lb)+lb;      % ��ʼ������λ��
Convergence_curve=zeros(1,Iter);        % ��������
l=0;        %ѭ��������¼
 
%% �������
while l<Iter
    for i=1:size(Positions,1)  
        
       % �����߽紦��
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
        
        % ���������Ӧ�Ⱥ���
        fitness=f(Positions(i,:));
        
        % ���� Alpha, Beta, and Delta
        if fitness<Alpha_score 
            Alpha_score=fitness; 
            Alpha_pos=Positions(i,:);
        end    
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness; 
            Beta_pos=Positions(i,:);
        end     
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 
            Delta_score=fitness; 
            Delta_pos=Positions(i,:);
        end
    end
       
    a=2-l*((2)/Iter); % �������Ӵ�2���Եݼ���0
    
    % ���»��Ǹ����λ��
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
end
plot(Alpha_pos, f(Alpha_pos), '*r');
 
figure(2);
plot(Convergence_curve);
title('��������'); 
 
display(['The best solution obtained by GWO is : ', num2str(Alpha_pos)]);
display(['The best optimal value of the objective funciton found by GWO is : ', num2str(Alpha_score)]);
