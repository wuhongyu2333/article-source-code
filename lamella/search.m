% clc
% clear
tic
%load('C:\Users\90434\Desktop\mat\abc_bp1.1.mat')
new_history=unique(pos_history,'rows');
cost_list=zeros(size(new_history,1),1);
for i = 1:size(new_history,1)
    cost_list(i)=Sphere(new_history(i,:));
end
new_history=[cost_list,new_history];
new_history=sortrows(new_history,1);
% [f,location]=unique(pos_history,'rows','first');
% res=sortrows([location,f]);
% new_history=res(:,2:11);
% num_his=size(new_history,1);
% cost_list=zeros(num_his,1);

%% 二分法
% up=1;
% down=size(new_history,1);
% judge=zeros(down,1);
% judge(up)=ansysfem(new_history(up,:));
% judge(down)=ansysfem(new_history(down,:));
% if judge(up)<0
%     disp('全都不行')
% end
% if judge(down)>0
%     disp('全都可以')
% end
% while (down~=up+1)
%     middle=round((up+down)/2);
%     judge(middle)=ansysfem(new_history(middle,:));
%     if judge(middle)>0
%         up=middle;
%     else
%         down=middle;
%     end 
% end

%% 自上而下遍历
for i = 1:size(new_history,1)
    [d,se]=ansysfem(new_history(i,2:11));
    if d<2&&se<2.5e4
        break
    end
end

final_ans=new_history(i,2:11);
AreaSet = [1.62, 1.8, 1.99, 2.13,2.38, 2.62, 2.63, 2.88, 2.93, 3.09, 3.13, 3.38, 3.47, 3.55, 3.63,3.84, 3.87, 3.88, 4.18, 4.22, 4.49, 4.59, 4.80, 4.97, 5.12, 5.74,7.22, 7.97, 11.50, 13.50, 13.90, 14.20, 15.50, 16.00, 16.90,18.80, 19.90, 22.00, 22.90, 26.50, 30.00, 33.5, 35, 37.5, 40,42.5, 45, 47.5, 50, 52.5, 55, 57.5, 60, 62.5, 65, 67.5, 70, 72.5,75, 77.5, 80, 82.5, 85, 87.5, 90];
final_area = AreaSet(final_ans);
cost=Sphere(new_history(i,2:11));
toc