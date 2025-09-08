function route_all = hybridAstar(startPose, goalPose, sign, min_r, safe_dis, step, ob_coo, P3, row, col)

opened=[startPose 0 0 0 0 1 0];%1x,2y,3theta,4方向、5g值，6h值，7f值，8二叉树中的位置，9父代编号
%---------------------调用A*--------------------
dis_astar=Astar_fun(fliplr(ceil(startPose(1:2))),fliplr(ceil(goalPose(1:2))),sign);

[dis_rs,~]=reeds_shepp_fun(startPose,goalPose,min_r); % 找出当前点到终点的RS曲线
opened(1,6)=max(dis_astar,dis_rs);                    % h值为RS曲线（考虑运动学不考虑障碍物）和A*结果（相反）中长的
opened(1,7)=opened(1,5)+opened(1,6);                  % f = g + h
now_point=opened;                                     % 当前节点加入open
nodeIndex = 1;                                        %节点编码
nodeArray(nodeIndex).x=now_point(1);
nodeArray(nodeIndex).y=now_point(2);
nodeArray(nodeIndex).sita=now_point(3);
nodeArray(nodeIndex).D=now_point(4);
nodeArray(nodeIndex).g=now_point(5);
nodeArray(nodeIndex).h=now_point(6);
nodeArray(nodeIndex).f=now_point(7);
nodeArray(nodeIndex).ind=now_point(8);
nodeArray(nodeIndex).parent=now_point(9);
nodeArray(nodeIndex).route=[];
nodeIndex = nodeIndex + 1;
[min_num,index] = min(opened(:,7));             % 找出当前你open中f最小的加入closed

while ceil(now_point(1))~=ceil(goalPose(1))||ceil(now_point(2))~=ceil(goalPose(2))   % 结束条件(到达终点)，
    opened(index,:) = [];     % 从开放列表中删除
    for i=1:3
        [isok,x,y,sita,route]=find_route_fun(now_point,i,step,min_r,safe_dis,ob_coo); % 寻找route
        if x<=0||x>col||y<=0||y>row
            isok=1;
        end
        if isok==0
            temp=[x,y,sita,0,0,0,0,nodeIndex,now_point(8)];
            if i>3
                temp(4)=1;
            end
            temp(5)=now_point(5)+step+sum(abs(temp(3)-now_point(3)))*P3;
            dis_astar=Astar_fun(fliplr(ceil(temp(1:2))),fliplr(ceil(goalPose(1:2))),sign);
            [dis_rs,~]=reeds_shepp_fun(temp(1:3),goalPose,min_r);
            temp(6)=max(dis_astar,dis_rs);
            temp(7)=temp(5)+temp(6);
            opened=[opened;temp];
            nodeArray(nodeIndex).x=temp(1);
            nodeArray(nodeIndex).y=temp(2);
            nodeArray(nodeIndex).sita=temp(3);
            nodeArray(nodeIndex).D=temp(4);
            nodeArray(nodeIndex).g=temp(5);
            nodeArray(nodeIndex).h=temp(6);
            nodeArray(nodeIndex).f=temp(7);
            nodeArray(nodeIndex).ind=temp(8);
            nodeArray(nodeIndex).parent=temp(9);
            nodeArray(nodeIndex).route=route;
            nodeIndex = nodeIndex + 1;
            if i<=3
                plot(route(:,1),route(:,2),'b-')
            else
                plot(route(:,1),route(:,2),'g-')
            end
            grid off
            drawnow
            plot(route(end,1),route(end,2), 'o','markersize', 2,'markerfacecolor','r','MarkerEdgeColor', 'm')
        end
    end
    [min_num,index] = min(opened(:,7));
    now_point=opened(index,:);
    if norm(now_point(1:2)-goalPose(1:2))<  1 * step
        break
    end
end
node_temp=nodeArray(now_point(8));
index=now_point(8);
while node_temp.parent~=0
    node_temp=nodeArray(node_temp.parent);
    index=[index node_temp.ind];
end
index=fliplr(index);
route_all=startPose;
for i=1:length(index)
    route=nodeArray(index(i)).route;
    route_all=[route_all;route(2:end,:)];
end
% [~,route]=reeds_shepp_fun(now_point(1:3),goalPose,min_r); % 得到最后一段
% route_all=[route_all;route(2:end,:)];
route = [goalPose(1) goalPose(2) goalPose(3)];
route_all=[route_all;route];

size_car=[1 0.6 0.4];
[h1,h2]=plot_car(route_all(1,:),size_car);
dis_all=0;
for i=2:size(route_all,1)
    dis_all=dis_all+norm(route_all(i,1:2)-route_all(i-1,1:2));
%     r_lin=route_all(i,:);
    r_lin(1) = route_all(i,2);
    r_lin(2) = route_all(i,1);
    r_lin(3) = route_all(i,3);
    delete(h1)
    delete(h2)
    plot(route_all(i-1:i,1),route_all(i-1:i,2),'r-','LineWidth',2)
    [h1,h2]=plot_car(r_lin,size_car);
    drawnow
    drawnow;
    %pause(0.03);
end
disp(['总距离：',num2str(dis_all)])

end