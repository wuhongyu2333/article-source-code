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
cost=Sphere(new_history(i,2:11));
toc