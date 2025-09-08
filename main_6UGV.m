close all
clear
clc

%% 读取地图并初始化参数
figure
mapOriginal=imbinarize(imread('Maps/map_dense50.bmp')); %从bmp文件读取地图
% mapOriginal=im2double(mapOriginal);
% 设定地图x和y方向分辨率
res = 50;
resolutionX = res;
resolutionY = res;
% 根据设定分辨率重新设置地图的大小
mapResized=imresize(mapOriginal,[resolutionX resolutionY]);
map=mapResized; 

% 细分地图，用于生成安全走廊
mapDense =  imresize(mapOriginal,[resolutionX*10 resolutionY*10]);

%连接矩阵-定义机器人可允许的动作
conn=[1 1 1;
      1 2 1;
      1 1 1];
% 是否显示节点的处理过程
% display_process=true; 
display_process=false; 

% 障碍物膨胀
% for i=1:size(mapResized,1)
%     for j=1:size(mapResized,2)
%         if mapResized(i,j)==0 % 如果是障碍物
%             % 扩展距离2个栅格，用于A*搜索
%             if i-1>=2, map(i-2:i-1,j)=0; end
%             if j-1>=2, map(i,j-2:j-1)=0; end
%             if i+1<=size(map,1) - 1, map(i+1:i+2,j)=0; end
%             if j+1<=size(map,2) - 1, map(i,j+1:j+2)=0; end
% 
%             if i-1>=2 && j-1>=2, map(i-2:i-1,j-2:j-1)=0; end
%             if i-1>=2 && j+1<=size(map,2) - 1, map(i-2:i-1,j+1:j+2)=0; end
%             if i+1<=size(map,1) - 1 && j-1>=2, map(i+1:i+2,j-2:j-1)=0; end
%             if i+1<=size(map,1) - 1 && j+1<=size(map,2) - 1, map(i+1:i+2,j+1:j+2)=0; end
%         end
%     end
% end

mapSafe = mapResized;
for i=1:size(mapResized,1)
    for j=1:size(mapResized,2)
        if mapResized(i,j)==0 % 如果是障碍物
            % 扩展距离1个栅格，用于安全走廊
            if i-1>=1, mapSafe(i-1,j)=0; end
            if j-1>=1, mapSafe(i,j-1)=0; end
            if i+1<=size(map,1), mapSafe(i+1,j)=0; end
            if j+1<=size(map,2), mapSafe(i,j+1)=0; end

            if i-1>=1 && j-1>=1, mapSafe(i-1,j-1)=0; end
            if i-1>=1 && j+1<=size(map,2), mapSafe(i-1,j+1)=0; end
            if i+1<=size(map,1) && j-1>=1, mapSafe(i+1,j-1)=0; end
            if i+1<=size(map,1) && j+1<=size(map,2), mapSafe(i+1,j+1)=0; end
        end
    end
end
map = mapSafe;
mapSafe = mapResized;

% 绘制灰度图
image((map==0).*0 + (map==1).*255 + (mapResized-map).*150);
colormap(gray(256));
hold on

if length(find(conn==2))~=1, error('no robot specified in connection matrix'); end

% 多机搜索
num = 6;
path = cell(num,1);
swarm_path = cell(num,1);
swarm_path_pre = cell(num,1);

% 定义期望编队构型
% des = [0,0; 2,2; 2,-2;];
% des = [0,0; 4,2; 4,-2;];

% des = [0,0; 4,0; 4,4; 0,4];

% des = [0,0; 4,0; 4,-4; 0,-4];

% des = [0,1; 1,1; 2,1; 2,0; 1,0; 0,0];

% des = [0,2; 1,2; 2,2; 2,0; 1,0; 0,0];

des = [0,0; 3,0; 6,0; 6,3; 3,3; 0,3];

% des = [0,0; 4,0; 8,0; 8,4; 4,4; 0,4];

% des = [0,0; 2,0; 4,0; 6,0; 6,2; 4,2; 2,2; 0,2];

% des = [0,0; 2,-2; 4,-1; 4,1; 2,2];

% des = [0,0; 2,-3; 6,-2; 6,2; 2,3];

formation_ctr = [sum(des(:,1))/num,sum(des(:,2))/num];

start = zeros(num,2);
goal = zeros(num,2);
color = ['r','g','b','y','c','m','r','g','b','y','c','m'];

start_angle = pi/2; % 起始角度
goal_angle =  pi/2;  % 目标角度
% goal_angle =  pi;

Rs =  [cos(start_angle - pi/2), -sin(start_angle - pi/2);
       sin(start_angle - pi/2),  cos(start_angle - pi/2);];
Rg =  [cos(goal_angle - pi/2), -sin(goal_angle - pi/2);
       sin(goal_angle - pi/2),  cos(goal_angle - pi/2);];

    text1 = ('Please select formation start point in the image');
    disp(text1);
    [x,y] = ginput(1);
    hold on
    start(1,:) = [double(int8(y)) double(int8(x))];
    for i = 2 : num
        start(i,:) = start(1,:) + (Rs*(des(i,:)' - des(1,:)'))';
    end
    plot(start(:,2),start(:,1),"Color",'k');
    plot([start(1,2),start(end,2)],[start(1,1),start(end,1)],"Color",'k');
    hold on

    text2 = ('Please select formation goal point in the image');
    disp(text2);
    [x,y] = ginput(1);
    goal(1,:) = [double(int8(y)) double(int8(x))];
    for i = 2 : num
        goal(i,:) = goal(1,:) + (Rg*(des(i,:)' - des(1,:)'))';
    end
    plot(goal(:,2),goal(:,1),"Color",'k');
    plot([goal(1,2),goal(end,2)],[goal(1,1),goal(end,1)],"Color",'k');
    hold on


%     start = [35	27
% 39	27
% 39	23
% 35	23];
% 
%     goal = [10	27
% 14	27
% 14	23
% 10	23];
% 
% start = [40	25
% 44	25
% 44	21
% 40	21];
% 
%     goal = [10	24
% 14	24
% 14	20
% 10	20] - [4 -1
% 4	-1
% 4	-1
% 4	-1];

    start_ctr(1) = sum(start(:,1))/num;
    start_ctr(2) = sum(start(:,2))/num;
    goal_ctr(1) = sum(goal(:,1))/num;
    goal_ctr(2) = sum(goal(:,2))/num;

%% hybrid A*
row = resolutionX;
col = resolutionY;
map_hybrid = ~mapResized;
sign = flip(map_hybrid);
% 定义初始位置和朝向角

start_ctrPose = [start_ctr(2) row-start_ctr(1) start_angle];
goal_ctrPose = [goal_ctr(2) row-goal_ctr(1) goal_angle];
for i = 1 : num
    startPose(i,1) = start(i,2);
    startPose(i,2) = row - start(i,1);
    startPose(i,3) = start_angle;
    goalPose(i,1) = goal(i,2);
    goalPose(i,2) = row - goal(i,1);
    goalPose(i,3) = goal_angle;
end

% 弯道参数
% min_r = 2;%最小转弯半径
% safe_dis = 1.5;%与障碍物的安全距离
% step = 3;%扩展步长

% 正常参数
min_r = 3;%最小转弯半径
safe_dis = 2.5;%与障碍物的安全距离(circle)
step = 2.5;%扩展步长

P3 = 1;%角度惩罚系数
ob_coo=[];
figure%画障碍图
hold on
axis equal
for i=1:row
    for j=1:col
        if sign(i,j) == 1
            y=[i-1,i-1,i,i];
            x=[j-1,j,j,j-1];
            h=fill(x,y,[0.4, 0.4, 0.4]);
            set(h,'facealpha',1,'edgealpha',0)
            ob_coo=[ob_coo;[j,i]];
        end
    end
end
axis([0 row 0 col])%限制图的边界
xlabel('x')
ylabel('y')
box on

% for i=1:row
%     plot([0 col],[i i],'k-');
% end
% for i=1:col
%     plot([i i],[0 row],'k-');%画网格线
% end

plot(start_ctrPose(1),start_ctrPose(2), 'o','markersize', 5,'markerfacecolor','y','MarkerEdgeColor', 'y')
plot(goal_ctrPose(1),goal_ctrPose(2),'o','markersize', 5,'markerfacecolor','g','MarkerEdgeColor', 'g')
% set(gca,'YDir','reverse');

% %% 编队中心路径搜索（混合A*）
ctr_path = hybridAstar(start_ctrPose, goal_ctrPose, sign, min_r, safe_dis, step, ob_coo, P3, row, col);
temp = ctr_path(:,2);
ctr_path(:,2) = ctr_path(:,1);
ctr_path(:,1) = row - temp;
ctr_path(:,3) = -ctr_path(:,3);

% center_path = load('center_path.mat');
% ctr_path = cell2mat(struct2cell(center_path));


%% 集群A*搜索
flag = 1;
for i = 1 : num
    path{i} = a_star(i, flag, ctr_path, start(i,:), goal(i,:),mapOriginal,mapResized,map,conn,display_process,resolutionX,resolutionY, start);
end

%% 路径点致密化与归一化
dt = 1;
h = 2; % 插入加密点数量为h-1个
t = dt;
new_path = cell(num,1);

M = size(ctr_path,1);
H = 1 + h*(M-1);
% 虚拟领航者（编队中心）路径点致密化

% new_ctr_path = segmentation(ctr_path,t,h,M,H);
new_ctr_path = ctr_path;

figure
imshow(mapOriginal,'InitialMagnification','fit');
for i = 1 : num
    M = size(path{i},1);
    H = 1 + h*(M-1);
    % 加密原路径点
    new_path{i} = segmentation(path{i},t,h,M,H);
    path_original = [(new_path{i}(:,1)*size(mapOriginal,1))/resolutionX (new_path{i}(:,2)*size(mapOriginal,2))/resolutionY];
    l = line(path_original(:,2),path_original(:,1), 'Marker','.');
    hold on
    ugv(i) = plot(path_original(1,2),path_original(1,1),'o','Color',color(i));
    hold on
    plot(path_original(end,2),path_original(end,1),'o','Color',color(i));
    hold on
end
% legend([l,ugv(3),ugv(2),ugv(1)],'路径','无人车1','无人车2','无人车3')
legend([l,ugv(3),ugv(2),ugv(1)],'Path','UGV1','UGV2','UGV3','Location','NorthWest')

longest_path = 0;
for i = 1 : num
    current_path = size(new_path{i},1);
    longest_path = max(current_path,longest_path);
end
for i = 1 : num
    if size(new_path{i},1) < longest_path
        endnum = size(new_path{i},1);
        diff = longest_path - endnum;
        for k = 1 : diff
            new_path{i} = [new_path{i}; new_path{i}(endnum,1),new_path{i}(endnum,2),new_path{i}(endnum,3)];
        end
    end
end

% 将虚拟领航者与其他无人车的路径点数量归一化
if size(new_path{1},1) > size(new_ctr_path,1)
    k = size(new_ctr_path,1);
    for j = 1 : size(new_path{1},1) - size(new_ctr_path,1)
        new_ctr_path = [new_ctr_path; new_ctr_path(k,1),new_ctr_path(k,2),new_ctr_path(k,3)];
    end
end
for i = 1 : num
    if size(new_path{i},1) < size(new_ctr_path,1)
        k = size(new_path{i},1);
        for j = 1 : size(new_ctr_path,1) - size(new_path{i},1)
            new_path{i} = [new_path{i}; new_path{i}(k,1),new_path{i}(k,2),new_path{i}(k,3)];
        end
    end
end

H = size(new_ctr_path,1);

%% 画出中心轨迹
figure
imshow(mapOriginal,'InitialMagnification','fit');
cmap = colormap(gray);  % 先获取默认灰度 colormap
cmap(1, :) = [0.4, 0.4, 0.4];  % 将黑色（第1行）替换为灰色
z = new_ctr_path;
z = [(z(:,1)*size(mapOriginal,1))/resolutionX (z(:,2)*size(mapOriginal,2))/resolutionY z(:,3)];
    line( z(:,2),z(:,1));
    hold on
    plot( z(1,2),z(1,1) ,'o', 'Color', 'b');
    hold on
    plot( z(end,2),z(end,1),'o', 'Color', 'b');
    hold on
    axis on

%% 编队期望代价定义
A = cell(H,1);
B = cell(H,1);
dir = -new_ctr_path(:,3);
for n = 1 : H
    % 旋转矩阵
    R = [cos(start_angle - dir(n)), -sin(start_angle - dir(n));
         sin(start_angle - dir(n)),  cos(start_angle - dir(n));];
%     R = [cos(dir(n) - start_angle), -sin(dir(n) - start_angle);
%          sin(dir(n) - start_angle),  cos(dir(n) - start_angle);];
    for i = 1 : num
        A{n}(i,1:2) = (des(i,:) - formation_ctr(1,:))*R;
        for j = 1 : num
            if j == i + 1
            B{n}(j,1:2) = (des(j,:) - des(i,:))*R;
            end
        end
    end
end
A_des = A;
B_des = B;

% for i = 1 : num
%     new_path{i} = new_path{i}(1:10,:);
% end
% new_ctr_path = new_ctr_path(1:10,:);

tic
opt_flag = 1;
for n = 1 : num
    swarm_path_pre{n} = optimization(num, n, opt_flag, resolutionX, resolutionY, map, mapOriginal, mapResized, mapSafe, mapDense, path{n}, new_path{n}, A_des, B_des, new_ctr_path, swarm_path_pre, goal_angle);
end
toc
for n = 1 : num
%     swarm_path{n} = [(swarm_path_pre{n}(:,1)*size(mapOriginal,1))/resolutionX (swarm_path_pre{n}(:,2)*size(mapOriginal,2))/resolutionY swarm_path_pre{n}(:,3)];
    swarm_path{n} = swarm_path_pre{n};
end

%% 可视化
figure
imshow(mapOriginal,'InitialMagnification','fit');

image((map==0).*0 + (map==1).*255 + (mapResized-map).*150);
pbaspect([1.12 1 1])

cmap = colormap(gray);  % 先获取默认灰度 colormap

colormap(cmap);  % 应用自定义 colormap
color = ['r','g','b','y','c','m','r','g','b','y','c','m'];
hold on

for i = 1 : num
    z = swarm_path{i};
    l = line(z(:,2),z(:,1));
    hold on
    ugv(i) = plot( z(1,2),z(1,1) ,'o', 'Color', color(i));
    hold on
    g = plot( z(end,2),z(end,1),'o', 'Color', color(i));
    hold on
end

pic_num = 1;
R = R*size(mapOriginal,1)/resolutionX;

% 带车辆模型动态显示
% car_size = [0.5 0.3 0.2];
% car_size = [0.6 0.36 0.24];
% car_size = [0.8 0.48 0.32];
car_size = [1.2 0.72 0.48];

h1 = zeros(num,1);
h2 = zeros(num,1);
z = swarm_path;
for n = 1 : num
    [h1(n),h2(n)]=plot_car(z{n}(1,:),car_size);
    hold on
end
    l1 = line([z{1}(1,2),z{2}(1,2)],[z{1}(1,1),z{2}(1,1)],'color','k');
    l2 = line([z{2}(1,2),z{3}(1,2)],[z{2}(1,1),z{3}(1,1)],'color','k');
    l3 = line([z{3}(1,2),z{4}(1,2)],[z{3}(1,1),z{4}(1,1)],'color','k');
    l4 = line([z{4}(1,2),z{1}(1,2)],[z{4}(1,1),z{1}(1,1)],'color','k');
for i = 2 : H
    delete(h1)
    delete(h2)
    delete(l1)
    delete(l2)
    delete(l3)
    delete(l4)
    for n = 1 : num
        r_lin=z{n}(i,:);
        p = plot(z{n}(i-1:i,2),z{n}(i-1:i,1),'r-','LineWidth',2);
        hold on
        [h1(n),h2(n)]=plot_car(r_lin,car_size);
        hold on
    end
    l1 = line([z{1}(i,2),z{2}(i,2)],[z{1}(i,1),z{2}(i,1)],'color','k');
    l2 = line([z{2}(i,2),z{3}(i,2)],[z{2}(i,1),z{3}(i,1)],'color','k');
    l3 = line([z{3}(i,2),z{4}(i,2)],[z{3}(i,1),z{4}(i,1)],'color','k');
    l4 = line([z{4}(i,2),z{1}(i,2)],[z{4}(i,1),z{1}(i,1)],'color','k');
        title('UGV Trajectory Optimization');
        xlabel('x(m)');
        ylabel('y(m)');
        set(gca,'TickDir','in')
        axis on
        switch num
            case 3
                legend([ugv(1),ugv(2),ugv(3)],'ugv1','ugv2','ugv3')
            case 4
                legend([ugv(1),ugv(2),ugv(3),ugv(4)],'ugv1','ugv2','ugv3','ugv4')
            case 6
                legend([ugv(1),ugv(2),ugv(3),ugv(4),ugv(5),ugv(6)],'ugv1','ugv2','ugv3','ugv4','ugv5','ugv6')
        end
        drawnow;

    F=getframe(gcf);
    I=frame2im(F);
    [I,map]=rgb2ind(I,256);

    if pic_num == 1
    imwrite(I,map,'test6.gif','gif','Loopcount',inf,'DelayTime',0.2);

    else
    imwrite(I,map,'test6.gif','gif','WriteMode','append','DelayTime',0.2);
    end

    pic_num = pic_num + 1;
    pause(0.01);
    
end
delete(h1)
delete(h2)