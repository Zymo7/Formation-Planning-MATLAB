function [c, ceq] = constraints(flag, u, H, t, new_path, sc, id, num, swarm_path, goal_angle)
R = 0.1;
error = 0.05;
safe_distance = 0.5;
z = zeros(H,3);

sd_con = zeros((id-1)*H,1);% safe distance constraint 车间安全距离约束
sc_con = zeros(4*H,1); % safe corridor constraint 
sg_con = zeros(2,1); % start-goal constraint

    z(1,1:2) = new_path(1,1:2); 
    z(1,3) = atan2( (new_path(2,1) - new_path(1,1) ), ( new_path(2,2) - new_path(1,2) ) );
    theta = z(1,3);
    for i = 2 : H
        theta = theta + u(i-1,2)*t;
        T = [sin(theta),0; cos(theta),0; 0,1];
        z(i,:) = z(i-1,:) + u(i-1,1:2)*T';
    end

for i = 1 : id - 1
    for j = 1 : H
        sd_con((4*j-3):4*j, 1) = 2*R - norm(swarm_path{i}(j,1:2) - z(j,1:2));
    end
end

    sc_con(:,1) = [sc(:,1) - z(:,1) + safe_distance;
                   z(:,1) - sc(:,2) + safe_distance;
                   sc(:,3) - z(:,2) + safe_distance;
                   z(:,2) - sc(:,4) + safe_distance;]; % 安全走廊约束，每个点的行列需要在安全走廊内部


    sg_con(1:2,1) = [sqrt( (z(1,1) - new_path(1,1))^2 + (z(1,2) - new_path(1,2))^2 ) - error;
                     sqrt( (z(H,1) - new_path(H,1))^2 + (z(H,2) - new_path(H,2))^2 ) - error;]; % 起点终点约束
    
if flag == 0
    c = [
         sc_con;
         sg_con;
         ];  % <= 0
    ceq = [
        z(H,3)+goal_angle;
        z(1,3)+start_angle;
        ];
else
    c = [
%          sd_con;
         sc_con;
         sg_con;
         % z(H,3)+pi/2-0.1;
         % z(1,3)+pi/2-0.1;
         ];  % <= 0
    ceq = [
        z(H,3)+goal_angle;
        % z(1,3)+pi/2;
        ];
end