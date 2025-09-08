% 状态更新方程
function z = update_states(u, H, t, new_path)
    z = zeros(H, 3);
    z(1, 1:2) = new_path(1, 1:2);
    z(1, 3) = 0;

    for i = 2:H
        theta = z(i-1, 3) + u(i-1, 2) * t;
        T = [sin(theta), 0; cos(theta), 0; 0, 1];
        z(i, :) = z(i-1, :) + [u(i-1, 1:2), 0] * T';
        z(i, 3) = z(i-1, 3) + u(i-1, 2) * t;  % 更新时间信息
    end
    
end