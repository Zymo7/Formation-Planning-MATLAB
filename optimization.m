function opt = optimization(num, id, flag, resolutionX,resolutionY,map,mapOriginal,mapResized,mapSafe,mapDense,path,new_path,A_des, B_des, ctr_traj, swarm_path, goal_angle)
%% 加密路径点并进行长度归一化
R = 0.1;
dt = 1;
% h = 2; % 插入加密点数量为h-1个
t = dt;

%% 初始化
H = size(new_path,1);
theta = 0;
initial_guess = zeros(H,2); % 初始解
sc = zeros(H,1); % 安全走廊
u = zeros(H,2); % 优化控制结果
z = zeros(H,3); % 优化轨迹点结果
opt = zeros(H,3); % 输出优化轨迹点结果


    % 生成安全走廊
        sc = safe_corridor(resolutionX,resolutionY, map, mapOriginal, mapResized, mapSafe, mapDense, new_path);
        % 生成初始解
        initial_guess(:,1:2) = initial_input_guess(new_path, H, t, resolutionX, resolutionY, mapOriginal, 1);
save sc sc

for i = 1 : H
    if initial_guess(i,1) == 0
        initial_guess(i,1) = 0.1;
    end
end

% 设置最大最小速度/角速度
v_min = 0; 
omega_min = -0.2;
v_max = 1; 
omega_max = 0.2;

v_min = 0.2; 
omega_min = -0.4;
v_max = 1; 
omega_max = 0.4;

lb = [];
ub = [];
lb_1 = [];
ub_1 = [];

    lb_1 = [lb_1, v_min, omega_min];
    ub_1 = [ub_1, v_max, omega_max];

for i = 1 : H
    lb = [lb;lb_1];
    ub = [ub;ub_1];
end

save lb lb
save ub ub
save sc sc
save initial_guess initial_guess

%% 非线性优化
options = optimoptions('fmincon', 'Algorithm', 'sqp', 'Display', 'iter', 'PlotFcns', 'optimplotfval','TolFun',1e+3,'StepTolerance',1e-14,'OptimalityTolerance', 1e+1, 'MaxFunEvals',100000,'UseParallel', true); 
% options.StepTolerance=1e-14;

% 定义优化问题
problem.objective = @(u) cost(flag, u, H, t, new_path, A_des, B_des, ctr_traj, swarm_path, id);
problem.x0 = initial_guess;  % 初始猜测
problem.lb = lb;% 变量下界
problem.ub = ub;% 变量上界

problem.nonlcon = @(u) constraints(flag, u, H, t, new_path, sc, id, num, swarm_path, goal_angle);
problem.solver = 'fmincon';
problem.options = options;

u = fmincon(problem);

% save u u

    z(1,1:2) = new_path(1,1:2); 
    z(1,3) = atan2( (new_path(2,1) - new_path(1,1) ), ( new_path(2,2) - new_path(1,2) ) );

    theta = z(1,3);
    for i = 2 : H
        theta = theta + u(i-1,2)*t;
        T = [sin(theta),0; cos(theta),0; 0,1];
        z(i,:) = z(i-1,:) + u(i-1,1:2)*T';
    end
%     z = [(z(:,1)*size(mapOriginal,1))/resolutionX (z(:,2)*size(mapOriginal,2))/resolutionY z(:,3)];

    opt = z;
save u u
save z z
end