 % 定义每两个点之间控制输入的变化量作为优化目标
function [c, z] = cost(flag, u, H, t, new_path, A_des, B_des, ctr_traj, swarm_path, id)

% path = new_path; % 输入的path是cell类型的多条路径点

% 权重矩阵
if flag == 0
    P = [100,0; %控制输入变化量
         0,100;];
    Q = [0,0;
         0,0];
else
    P = [150,0;
         0,150;];
    Q = [0,0;
         0,0];
    R1 = 1;
    R2 = 1;
end

A = cell(H,1);
B = cell(H,1);
cost1 = 0;    
cost2 = 0; 
cost3 = 0;
cost4 = 0;

z = zeros(H, 3);
delta_u = diff(u);

    % 每两个点之间控制输入的变化量
    for i = 1 : H-1
        row = delta_u(i,1:2);
        cost1 = cost1 + row*P*row';
    end

    % 与参考路径的偏差
    z(1,:) = new_path(1,:);
    z(1,1:2) = new_path(1,1:2); 
    z(1,3) = atan2( (new_path(2,1) - new_path(1,1) ), ( new_path(2,2) - new_path(1,2) ) );
    theta = z(1,3);
  
    for i = 2 : H
        theta = theta + u(i-1, 2) * t;
        T = [sin(theta), 0; cos(theta), 0; 0, 1];
        z(i,:) = z(i-1,:) + u(i-1, 1:2) * T';
    end
    
    for i = 1 : H
        delta_z = z(i,1:2) - new_path(i,1:2);
        cost2 = cost2 + delta_z*Q*delta_z';
    end


%% 编队中心点相对位置偏差
formation_cost = zeros(H-1);
if flag ~= 0
    for n = 1 : H-1
        A{n}(1,1:2) = z(n,1:2)- ctr_traj(n,1:2);
        delta_A = (A{n}(1,1:2) - A_des{n}(id,1:2))*R1*(A{n}(1,1:2) - A_des{n}(id,1:2))';
        cost3 = cost3 + delta_A;
        formation_cost(n) = cost3;
    end
end

%% 编队邻居间相对位置偏差
if flag ~= 0 && id > 1
    for n = 1 : H-1
        B{n}(1,1:2) = z(n,1:2)- swarm_path{id-1}(n,1:2);
        delta_B = (B{n}(1,1:2) - B_des{n}(id,1:2))*R2*(B{n}(1,1:2) - B_des{n}(id,1:2))';
        cost4 = cost4 + delta_B;
    end
end

if flag == 0
    c = cost1 + cost2;
else
    c = cost1 + cost2 + cost3 + cost4;
end
% save formation_cost formation_cost
end