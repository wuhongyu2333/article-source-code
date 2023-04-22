clear
clc
tic
SearchAgents_no=1000; % Number of search agents
Max_iter=1000;

lb=1;
ub=65;
dim=10;
d_lim=2;
se_lim=2.5e4;

Leader_pos=zeros(1,dim);
Leader_score=inf; 
Positions = round(unifrnd(lb,ub,[SearchAgents_no,dim]));

Convergence_curve=zeros(1,Max_iter);
Convergence_position=zeros(Max_iter,dim);
t=0;
pos_history=[];

% Main loop
while t<Max_iter
    for i=1:size(Positions,1)
        
        % Return back the search agents that go beyond the boundaries of the search space
        Positions = round(Positions);
        Positions = max(Positions,lb);
        Positions = min(Positions,ub);
        
        % Calculate objective function for each search agent
        fitness=Sphere(Positions(i,:));
        
        % Update the leader
        if fitness<Leader_score % Change this to > for maximization problem
            d = abs(displacement(Positions(i,:)));
            se = abs(stress(Positions(i,:)));
            if d<=d_lim&&se<=se_lim
                Leader_score=fitness; % Update alpha
                Leader_pos=Positions(i,:);
                pos_history=[pos_history;Leader_pos];
            end
        end
        
    end
    
    a=2-t*((2)/Max_iter); % a decreases linearly fron 2 to 0 in Eq. (2.3)
    
    % a2 linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a2=-1+t*((-1)/Max_iter);
    
    % Update the Position of search agents 
    for i=1:size(Positions,1)
        r1=rand(); % r1 is a random number in [0,1]
        r2=rand(); % r2 is a random number in [0,1]
        
        A=2*a*r1-a;  % Eq. (2.3) in the paper
        C=2*r2;      % Eq. (2.4) in the paper
        
        
        b=1;               %  parameters in Eq. (2.5)
        l=(a2-1)*rand+1;   %  parameters in Eq. (2.5)
        
        p = rand();        % p in Eq. (2.6)
        
        for j=1:size(Positions,2)
            
            if p<0.5   
                if abs(A)>=1
                    rand_leader_index = floor(SearchAgents_no*rand()+1);
                    X_rand = Positions(rand_leader_index, :);
                    D_X_rand=abs(C*X_rand(j)-Positions(i,j)); % Eq. (2.7)
                    Positions(i,j)=X_rand(j)-A*D_X_rand;      % Eq. (2.8)
                    
                elseif abs(A)<1
                    D_Leader=abs(C*Leader_pos(j)-Positions(i,j)); % Eq. (2.1)
                    Positions(i,j)=Leader_pos(j)-A*D_Leader;      % Eq. (2.2)
                end
                
            elseif p>=0.5
              
                distance2Leader=abs(Leader_pos(j)-Positions(i,j));
                % Eq. (2.5)
                Positions(i,j)=distance2Leader*exp(b.*l).*cos(l.*2*pi)+Leader_pos(j);
                
            end
            
        end
    end
    t=t+1;
    Convergence_curve(t)=Leader_score;
    Convergence_position(t,:)= Leader_pos;
    disp(['Iteration ' num2str(t) ': Best Cost = ' num2str(Leader_score)]);


end
toc