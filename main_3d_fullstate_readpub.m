%% ros init
%% 注意：ros端需要先运行roscore
%% 注意：每次使用完必须先在matlab运行rosshutdown，再在Ubuntu上结束ros，否则ubuntu上会继续存在节点！！！！！
% clc;clear;close all;
%写入ubuntu端ifconfig得到的ip地址，端口号11311
rosshutdown
setenv('ROS_MASTER_URI','http://192.168.1.77:11311')
% setenv('ROS_MASTER_URI','http://172.20.10.4:11311')
%初始化ros（roscore）
rosinit
%写入自定义消息
load('traj.mat');
% load('timet.mat');
% load('exp1_vel.mat');
%% ros
% 创建publisher
fs_pub1 = rospublisher('/control1/filter_p','geometry_msgs/Point');
fs_pub2 = rospublisher('/control2/filter_p','geometry_msgs/Point');
fs_pub3 = rospublisher('/control3/filter_p','geometry_msgs/Point');
fs_pub4 = rospublisher('/control4/filter_p','geometry_msgs/Point');

% flag_pub = rospublisher('/matlab/save_flag','std_msgs/Int32');
pause(2)% Wait to ensure publisher is setuprosAddons
%构建消息
fsmsg1 = rosmessage(fs_pub1);
fsmsg2 = rosmessage(fs_pub2);
fsmsg3 = rosmessage(fs_pub3);
fsmsg4 = rosmessage(fs_pub4);

% flagmsg = rosmessage(flag_pub);

%% path & vel
%初始高度
h = 0.5;
%得到初始位置与二维路径点
skip = 2;
tstep = 0.005 ;%时间间隔
% tstep = timet(2) - timet(1);
tstep = tstep * skip;
% 二维路径点
% cf1_pos_2d =  traj(:,1:2);
% cf2_pos_2d =  traj(:,4:5);
% cf3_pos_2d =  traj(:,7:8);
% cf4_pos_2d =  traj(:,10:11);
cf1_pos_2d =  traj(:,1:2);
cf2_pos_2d =  traj(:,3:4);
cf3_pos_2d =  traj(:,5:6);
cf4_pos_2d =  traj(:,7:8);
% % 转换为三维路径点，高度为h
[num,~] = size(cf1_pos_2d); % num 为轨迹点的总数
% cf1_pos_3d = [cf1_pos_2d,h*ones(num,1)];
% cf2_pos_3d = [cf2_pos_2d,h*ones(num,1)];
% cf3_pos_3d = [cf3_pos_2d,h*ones(num,1)];
% cf4_pos_3d = [cf4_pos_2d,h*ones(num,1)];
% 将三维坐标点写入消息，并发送
for k=1:10
    i=1;
    fsmsg1 = write_msg(cf1_pos_2d,i,fsmsg1);
    fsmsg2 = write_msg(cf2_pos_2d,i,fsmsg2);
    fsmsg3 = write_msg(cf3_pos_2d,i,fsmsg3);
    fsmsg4 = write_msg(cf4_pos_2d,i,fsmsg4);
    % 发送函数，第一个输入为publisher，第二个输入为发送内容
    send(fs_pub1,fsmsg1)
    send(fs_pub2,fsmsg2)
    send(fs_pub3,fsmsg3)
    send(fs_pub4,fsmsg4)
end

%% wait
status = 1;
while(status==1)
    status = input("1 = hold, any other number will start the pub process.");
end
% flagmsg.Data = 1;
% send(flag_pub,flagmsg);

%% pub
tic
xxxx = toc
for i = 1:skip:num
    %写入消息内容
    fsmsg1 = write_msg(cf1_pos_2d,i,fsmsg1);
    fsmsg2 = write_msg(cf2_pos_2d,i,fsmsg2);
    fsmsg3 = write_msg(cf3_pos_2d,i,fsmsg3);
    fsmsg4 = write_msg(cf4_pos_2d,i,fsmsg4);
    
    %保证频率
    while(~(toc-xxxx>=tstep))
    end
    xxxx = toc
    send(fs_pub1,fsmsg1)
    send(fs_pub2,fsmsg2)
    send(fs_pub3,fsmsg3)
    send(fs_pub4,fsmsg4)
end

