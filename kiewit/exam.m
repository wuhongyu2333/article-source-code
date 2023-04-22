% tic
% feature=[];
% label=[];
% for loop=1:20
%     input=unidrnd(65,10,1);
%     feature=[feature;input'];
%     fid = fopen('input.txt','wt');
%     fprintf(fid,'%g\n',input);
%     fclose(fid);
%     system('SET KMP_STACKSIZE=2048k & D:\SOFTWARE\ANSYS\v150\ansys\bin\winx64\ANSYS150.exe -b -p ane3fl -i D:\SOFTWARE\ANSYS\truss_10\gene_truss.mac -o  D:\SOFTWARE\ANSYS\truss_10\out.txt')
%     load output.txt   -ASCII
%     if isempty(output)
%         y_max=5;
%         y_min=-5;
%         s_max=50000;
%         s_min=-50000;
%     else
%         y_max=output(1);
%         y_min=output(2);
%         s_max=output(3);
%         s_min=output(4);
%     end
%     clear_txt=[];
%     fid = fopen('output.txt','wt');
%     fprintf(fid,'%g\n',clear_txt);
%     fclose(fid);
%     label=[label;output];
% end
% toc

% load result.txt   -ASCII
% a=[1,2,3,4,5,6]
% b=[6,5,4,3,2,1]
% c=max(a,b)

% AreaSet=[1.62, 1.8, 1.99, 2.13,2.38, 2.62, 2.63, 2.88, 2.93, 3.09, 3.13, 3.38, 3.47, 3.55, 3.63,3.84, 3.87, 3.88, 4.18, 4.22, 4.49, 4.59, 4.80, 4.97, 5.12, 5.74,7.22, 7.97, 11.50, 13.50, 13.90, 14.20, 15.50, 16.00, 16.90,18.80, 19.90, 22.00, 22.90, 26.50, 30.00, 33.5, 35, 37.5, 40,42.5, 45, 47.5, 50, 52.5, 55, 57.5, 60, 62.5, 65, 67.5, 70, 72.5,75, 77.5, 80, 82.5, 85, 87.5, 90]
% x=[1,2,3]
% % Aa=AreaSet(x);
% tic
% load MY_net
% 
% 
% %test_feature=[52.00000  28.00000  59.00000   9.00000  29.00000  31.00000   3.00000  61.00000  29.00000  27.00000]';
% test_label=-1.90359; 
% 
% 
% test_feature_deal=mapminmax('apply',test_feature,train_feature_format);
% t_sim = sim(net,test_feature_deal);  
% T_sim = mapminmax('reverse',t_sim,train_label_format);              %∑¥πÈ“ªªØ
% toc
% mse_net = mse(T_sim-test_label);   
% err=abs((T_sim-test_label)./test_label);
% err_ave=sum(err)/length(err);
% 
% T_sim=T_sim';
% clear_txt=[];
% %[42,1,39,32,1,1,28,39,38,1];
% 
% 
% input=[36,26,47,1,1,37,44,1,24,36]';
% fid = fopen('input.txt','wt');
% fprintf(fid,'%g\n',input);
% fclose(fid);
% system('SET KMP_STACKSIZE=2048k & D:\SOFTWARE\ANSYS\v150\ansys\bin\winx64\ANSYS150.exe -b -p ane3fl -i D:\SOFTWARE\ANSYS\truss_10\gene_truss.mac -o  D:\SOFTWARE\ANSYS\E016_FEM\out.txt')
% load output.txt   -ASCII
% if isempty(output)
%     
%     
%     d = 10;
% else
%     y_max = output(1);
%     y_min = output(2);
%     stress_max = output(3);
%     stress_min = output(4);
%     d = max(abs(y_max),abs(y_min));
%     stress = max(abs(stress_max),abs(stress_min));
% end
% fid = fopen('output.txt','wt');
% fprintf(fid,'%g\n',clear_txt);
% fclose(fid);

% clc
% tic
% [f,location]=unique(pos_history,'rows','first');
% res=sortrows([location,f]);
% new_history=res(:,2:11);
% num_his=size(new_history,1);
% cost_list=zeros(num_his,1);
% for i = 1:num_his
%     cost_list(i)=Sphere(new_history(num_his-i+1,:));
% end
% toc

%x=[42,1,39,32,1,1,28,39,38,1];


% x=[7,6,5,12,15,15];
% [d,se,sa]=ansysfem(x);
% [d2,se2,sa2]=ansysfem2(x);
% dn=displacement(x);
% sen=stress(x);
% san=stability(x);
%Sphere(x)

x=[30,5,10,10,10,10,10,10,10,10,10];
ansysfem(x)
% Sphere(x);
% time=[];
% for loop=1:3
%     a=1;
%     tic
%     name=['dome',num2str(loop)];
%     time=[time;toc];
%     save(num2str(name))
% end
