tic
%% Problem Definition

CostFunction = @(x) Sphere(x);        % Cost Function

BoundaryFunction=@(x) boundary(x);              % Boundary Function

nVar = 11;           % Number of Decision Variables

VarSize = [1 nVar];   % Decision Variables Matrix Size

d_lim = 0.2;                            % displacement limit
se_lim = 2.35e8;                        % stress limit
sa_lim = 4.2;                           % stability limit

clear_txt=[];


%% ABC Settings

MaxIt = 1000;              % Maximum Number of Iterations

nPop = 100;               % Population Size (Colony Size)

nOnlooker = nPop;         % Number of Onlooker Bees

L = round(0.6*nVar*nPop); % Abandonment Limit Parameter (Trial Limit)

a = 1;                    % Acceleration Coefficient Upper Bound

cal_curve=[];
pos_history=[];

%% Initialization

% Empty Bee Structure
empty_bee.Position = [];
empty_bee.Cost = [];


% Initialize Population Array
pop = repmat(empty_bee, nPop, 1);

% Initialize Best Solution Ever Found
BestSol.Cost = inf;

% Create Initial Population
for i = 1:nPop
    pop(i).Position = [unidrnd(61),unidrnd(13),unidrnd(34,1,9)];
    pop(i).Position = BoundaryFunction(pop(i).Position);
    pop(i).Cost = CostFunction(pop(i).Position);
    if pop(i).Cost <= BestSol.Cost
        d = abs(displacement(pop(i).Position));
        se = abs(stress(pop(i).Position));
        sa = abs(stability(pop(i).Position));
        cal_curve=[cal_curve;BestSol.Cost];
        if d<=d_lim && se<=se_lim && sa>=sa_lim
            BestSol = pop(i);
            pos_history=[pos_history;BestSol.Position];
        end
    end
end


% Abandonment Counter
C = zeros(nPop, 1);

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);



%% ABC Main Loop

for it = 1:MaxIt
    
    % Recruited Bees
    for i = 1:nPop
        
        % Choose k randomly, not equal to i
        K = [1:i-1 i+1:nPop];
        k = K(randi([1 numel(K)]));
        
        % Define Acceleration Coeff.
        phi = a*unifrnd(-1, +1, VarSize);
        
        % New Bee Position
        newbee.Position = pop(i).Position+phi.*(pop(i).Position-pop(k).Position);
        
        % Apply Bounds
        newbee.Position = BoundaryFunction(newbee.Position);

        % Evaluation
        newbee.Cost= CostFunction(newbee.Position);
        
        
        if newbee.Cost <= pop(i).Cost
            d = abs(displacement(newbee.Position));
            se = abs(stress(newbee.Position));
            sa = abs(stability(newbee.Position));
            cal_curve=[cal_curve;BestSol.Cost];
            if d<=d_lim && se<=se_lim && sa>=sa_lim
                pop(i) = newbee;
                pos_history=[pos_history;newbee.Position];
            else
                C(i) = C(i)+1;
            end
        end
    end
    
    % Calculate Fitness Values and Selection Probabilities
    F = zeros(nPop, 1);
    MeanCost = mean([pop.Cost]);
    for i = 1:nPop
        F(i) = exp(-pop(i).Cost/MeanCost); % Convert Cost to Fitness
    end
    P = F/sum(F);
    
    % Onlooker Bees
    for m = 1:nOnlooker
        
        % Select Source Site
        i = RouletteWheelSelection(P);
        
        % Choose k randomly, not equal to i
        K = [1:i-1 i+1:nPop];
        k = K(randi([1 numel(K)]));
        
        % Define Acceleration Coeff.
        phi = a*unifrnd(-1, +1, VarSize);
        
        % New Bee Position
        newbee.Position = pop(i).Position+phi.*(pop(i).Position-pop(k).Position);
        
        % Apply Bounds
        newbee.Position = BoundaryFunction(newbee.Position);
        
        % Evaluation
        newbee.Cost = CostFunction(newbee.Position);

        if newbee.Cost <= pop(i).Cost
            d = abs(displacement(newbee.Position));
            se = abs(stress(newbee.Position));
            sa = abs(stability(newbee.Position));
            cal_curve=[cal_curve;BestSol.Cost];
            if d<=d_lim && se<=se_lim && sa>=sa_lim
                pop(i) = newbee;
                pos_history=[pos_history;newbee.Position];
            else
                C(i) = C(i)+1;
            end
        end
        
    end
    
    % Scout Bees
    for i = 1:nPop
        if C(i) >= L
            pop(i).Position = [unidrnd(61),unidrnd(13),unidrnd(34,1,9)];
            % Apply Bounds
            pop(i).Position = BoundaryFunction(pop(i).Position);
            pop(i).Cost= CostFunction(pop(i).Position);
            C(i) = 0;
        end
    end
    
    % Update Best Solution Ever Found
    for i = 1:nPop
        
        if pop(i).Cost <= BestSol.Cost
            d = abs(displacement(pop(i).Position));
            se = abs(stress(pop(i).Position));
            sa = abs(stability(pop(i).Position));
            cal_curve=[cal_curve;BestSol.Cost];
            if d<=d_lim && se<=se_lim && sa>=sa_lim
                BestSol = pop(i);
                pos_history=[pos_history;BestSol.Position];
            end
        end
    end
    
    % Store Best Cost Ever Found
    BestCost(it) = BestSol.Cost;
    
    % Display Iteration Information

%     d=abs(displacement(BestSol.Position));
%     se=abs(stress(BestSol.Position));
    
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
%   disp(['max_d ' num2str(d) ', max_stress = ' num2str(se) ]);
    
%     br=sum(BestCost==BestSol.Cost);
%     if br>=30
%         break
%     end
    
end
    
%% Results
dn = abs(displacement(BestSol.Position));
sen = abs(stress(BestSol.Position));
san = abs(stability(BestSol.Position));
disp('final solution');
disp(['max_d ' num2str(dn) ', max_stress = ' num2str(sen) ', stability coefficient = ' num2str(san) ]);

[d,se,sa]=ansysfem(BestSol.Position);
disp('real solution ');
disp(['max_d ' num2str(d) ', max_stress = ' num2str(se) ', stability coefficient = ' num2str(sa) ]);
% figure;
% %plot(BestCost, 'LineWidth', 2);
% semilogy(BestCost, 'LineWidth', 2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;
toc
