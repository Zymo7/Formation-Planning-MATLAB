% 初始猜测
function u0 = initial_input_guess(new_path,H,t,resolutionX,resolutionY,mapOriginal, num)
    
u0 = zeros(H,2);
z0 = zeros(H,3);
for n = 1 : num
    for i = 2:H
        u0(i-1,1) = sqrt((new_path(i,2)-new_path(i-1,2))^2 + (new_path(i,1)-new_path(i-1,1))^2)/t;
        u0(i-1,2) = wrapToPi(new_path(i,3) - new_path(i-1,3))/t;
    end
    save u0 u0
    theta1 = 0;
    z0(1,1:2) = new_path(1,1:2); 
    z0(1,3) = atan2( (new_path(2,1) - new_path(1,1) ), ( new_path(2,2) - new_path(1,2) ) );
    z0(H,1:2) = new_path(end,1:2);
    for i = 2 : H
        theta1 = theta1 + u0(i-1,2)*t;
        T = [sin(theta1),0; cos(theta1),0; 0,1];
        z0(i,:) = z0(i-1,:) + u0(i-1,:)*T';
    end
    save z0 z0

%     new_path = [(new_path(:,1)*size(mapOriginal,1))/resolutionX (new_path(:,2)*size(mapOriginal,2))/resolutionY];    

%     z0 = [(z0(:,1)*size(mapOriginal,1))/resolutionX (z0(:,2)*size(mapOriginal,2))/resolutionY];    
% 
%     figure(4)
%     imshow(mapOriginal);
%     line(z0(:,2),z0(:,1));
end


end
