%% 用于将轨迹压缩，因为原始轨迹uav之间的间距过大，不利于实物实验的执行。压缩结果为pos_press，包含xyz坐标
%% 同时将轨迹进行加密，使得轨迹点变密集，便于飞机执行
% H = size(traj,1);
% t = 1;
h = 99; % 插入点数量为h个，即原始轨迹一段被分为h+1段，相邻两点时间间隔变为t/(h+1)
L = H+h*(H-1); % 插入后的总轨迹点数量
% delta_t = t/(h+1);
delta_t = 0.01;

timet = zeros(L-1,1);
for i = 1 : L-2
    timet(i+1,1) = timet(i,1) + delta_t;
end
save timet timet
load timet.mat timet

traj = zeros(L,num*2);

%% 将得到的轨迹swarm_path存在新的变量中（二维点）
for n = 1 : num
    for i = 1 : H
        traj(i,2*n-1) = swarm_path{n}(i,1);
        traj(i,2*n) = swarm_path{n}(i,2);
    end
end

%% 插入轨迹点
for i = 1 : num
    traj(:,2*i-1:2*i) = segmentation_2D(traj(:,2*i-1:2*i),0,h+1,H,0);
end
traj = traj(1:L-1,:);

%% 将坐标系转换为正常的世界系，即x水平向右，y垂直向上
for n = 1 : num
    for i = 1 : L-1
        tempx = traj(i,2*n);
        tempy = traj(i,2*n-1);
        traj(i,2*n) = row - tempx;
        traj(i,2*n-1) = row - tempy;
    end
end

% %% 压缩轨迹
traj = traj/4; % 4为压缩倍数，即原始间距为4m的话，压缩后变为1m

%% 将初始点挪到规定的位置
for n = 1 : num
        temp1 = traj(1,2*n-1);
        temp2 = traj(1,2*n);
    for i = 1 : L-1
        traj(i,2*n-1) = traj(i,2*n-1) - 2.25;
        traj(i,2*n) = traj(i,2*n) - 6.25 + 0.5;
        % traj(i,2*n-1) = traj(i,2*n-1) - 4.75;
        % traj(i,2*n) = traj(i,2*n) - 4.55;
    end
end

%% 中心轨迹
cen_traj = zeros(L,2);

%% 将得到的轨迹cen_path存在新的变量中（二维点）

for i = 1 : H
    cen_traj(i,1) = new_ctr_path(i,1);
    cen_traj(i,2) = new_ctr_path(i,2);
end

%% 插入轨迹点

cen_traj(:,1:2) = segmentation_2D(cen_traj(:,1:2),0,h+1,H,0);

cen_traj = cen_traj(1:L-1,:);

%% 将坐标系转换为正常的世界系，即x水平向右，y垂直向上

for i = 1 : L-1
    tempx = cen_traj(i,2);
    tempy = cen_traj(i,1);
    cen_traj(i,2) = row - tempx;
    cen_traj(i,1) = row - tempy;
end


% %% 压缩轨迹
cen_traj = cen_traj/4; % 4为压缩倍数，即原始间距为4m的话，压缩后变为1m

%% 将初始点挪到规定的位置

    temp1 = cen_traj(1,1);
    temp2 = cen_traj(1,2);
for i = 1 : L-1
    cen_traj(i,1) = cen_traj(i,1) - 2.25;
    cen_traj(i,2) = cen_traj(i,2) - 6.25 + 0.5;
end


%% 画图
% mapPress = imresize(mapOriginal, 1/4, 'bilinear'); 
figure
% imshow(mapPress,'InitialMagnification','fit');

cmap = colormap(gray);  % 先获取默认灰度 colormap
cmap(1, :) = [0.4, 0.4, 0.4];  % 将黑色（第1行）替换为灰色
colormap(cmap);  % 应用自定义 colormap
color = ['r','g','b','y','c','m','r','g','b','y','c','m'];
hold on

for i = 1 : num
    line(traj(:,2*i-1),traj(:,2*i));
    hold on
    plot( traj(1,2*i-1),traj(1,2*i) ,'o', 'Color', color(i));
    hold on
    plot( traj(end,2*i-1),traj(end,2*i),'o', 'Color', color(i));
    hold on
end
    line(cen_traj(:,1),cen_traj(:,2),'color','r');
    hold on
    plot(cen_traj(1,1),cen_traj(1,2) ,'o', 'Color', 'k');
    hold on
    plot(cen_traj(end,1),cen_traj(end,2),'o', 'Color', 'k');
    hold on
save cen_traj cen_traj

%% main1-obstacles
% r1 = 1;
% a1 = 3.7;
% b1 = -1.8;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor','k');
% hold on
% 
% r2 = 1;
% a2 = 0.75;
% b2 = 0.7;
% para = [a2-r2, b2-r2, 2*r2, 2*r2];
% rectangle('Position', para, 'Curvature', [1 1], 'FaceColor','k');

%% main3
% r1 = 1;
% a1 = 3;
% b1 = 0;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor','k');
% hold on
% 
% r2 = 1;
% a2 = -0.3;
% b2 = 0;
% para = [a2-r2, b2-r2, 2*r2, 2*r2];
% rectangle('Position', para, 'Curvature', [1 1], 'FaceColor','k');

axis equal
save traj traj
load traj traj

traj_table = table(timet,traj);
writetable(traj_table, 'traj_table.csv');