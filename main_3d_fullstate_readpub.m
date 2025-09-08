%% ros init
%% ע�⣺ros����Ҫ������roscore
%% ע�⣺ÿ��ʹ�����������matlab����rosshutdown������Ubuntu�Ͻ���ros������ubuntu�ϻ�������ڽڵ㣡��������
% clc;clear;close all;
%д��ubuntu��ifconfig�õ���ip��ַ���˿ں�11311
rosshutdown
setenv('ROS_MASTER_URI','http://192.168.1.77:11311')
% setenv('ROS_MASTER_URI','http://172.20.10.4:11311')
%��ʼ��ros��roscore��
rosinit
%д���Զ�����Ϣ
load('traj.mat');
% load('timet.mat');
% load('exp1_vel.mat');
%% ros
% ����publisher
fs_pub1 = rospublisher('/control1/filter_p','geometry_msgs/Point');
fs_pub2 = rospublisher('/control2/filter_p','geometry_msgs/Point');
fs_pub3 = rospublisher('/control3/filter_p','geometry_msgs/Point');
fs_pub4 = rospublisher('/control4/filter_p','geometry_msgs/Point');

% flag_pub = rospublisher('/matlab/save_flag','std_msgs/Int32');
pause(2)% Wait to ensure publisher is setuprosAddons
%������Ϣ
fsmsg1 = rosmessage(fs_pub1);
fsmsg2 = rosmessage(fs_pub2);
fsmsg3 = rosmessage(fs_pub3);
fsmsg4 = rosmessage(fs_pub4);

% flagmsg = rosmessage(flag_pub);

%% path & vel
%��ʼ�߶�
h = 0.5;
%�õ���ʼλ�����ά·����
skip = 2;
tstep = 0.005 ;%ʱ����
% tstep = timet(2) - timet(1);
tstep = tstep * skip;
% ��ά·����
% cf1_pos_2d =  traj(:,1:2);
% cf2_pos_2d =  traj(:,4:5);
% cf3_pos_2d =  traj(:,7:8);
% cf4_pos_2d =  traj(:,10:11);
cf1_pos_2d =  traj(:,1:2);
cf2_pos_2d =  traj(:,3:4);
cf3_pos_2d =  traj(:,5:6);
cf4_pos_2d =  traj(:,7:8);
% % ת��Ϊ��ά·���㣬�߶�Ϊh
[num,~] = size(cf1_pos_2d); % num Ϊ�켣�������
% cf1_pos_3d = [cf1_pos_2d,h*ones(num,1)];
% cf2_pos_3d = [cf2_pos_2d,h*ones(num,1)];
% cf3_pos_3d = [cf3_pos_2d,h*ones(num,1)];
% cf4_pos_3d = [cf4_pos_2d,h*ones(num,1)];
% ����ά�����д����Ϣ��������
for k=1:10
    i=1;
    fsmsg1 = write_msg(cf1_pos_2d,i,fsmsg1);
    fsmsg2 = write_msg(cf2_pos_2d,i,fsmsg2);
    fsmsg3 = write_msg(cf3_pos_2d,i,fsmsg3);
    fsmsg4 = write_msg(cf4_pos_2d,i,fsmsg4);
    % ���ͺ�������һ������Ϊpublisher���ڶ�������Ϊ��������
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
    %д����Ϣ����
    fsmsg1 = write_msg(cf1_pos_2d,i,fsmsg1);
    fsmsg2 = write_msg(cf2_pos_2d,i,fsmsg2);
    fsmsg3 = write_msg(cf3_pos_2d,i,fsmsg3);
    fsmsg4 = write_msg(cf4_pos_2d,i,fsmsg4);
    
    %��֤Ƶ��
    while(~(toc-xxxx>=tstep))
    end
    xxxx = toc
    send(fs_pub1,fsmsg1)
    send(fs_pub2,fsmsg2)
    send(fs_pub3,fsmsg3)
    send(fs_pub4,fsmsg4)
end

