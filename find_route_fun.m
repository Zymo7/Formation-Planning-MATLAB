function [isok,x,y,sita,route]=find_route_fun(now_point,ind,step,min_r,safe_dis,ob_coo)
isok=0;
theta=now_point(3);
n2=5;% 搜索过程中线段等分数量，n越大越平滑
if ind==1% 前进左转
    cenx = now_point(1)-min_r*sin(theta);
    ceny = now_point(2)+min_r*cos(theta);
    t = theta-pi/2+linspace(0,step/min_r,n2);
    dx = cenx+min_r*cos(t);
    dy = ceny+min_r*sin(t);
    angle=t+pi/2;
    route=[dx' dy' angle'];
    x=dx(end);
    y=dy(end);
    sita=angle(end);
    for i=1:n2
        temp=route(i,1:2);
        for j=1:size(ob_coo)
            if norm(temp-ob_coo(j,:))<safe_dis+(2^0.5)/2
                isok=1;
                return
            end
        end
    end
elseif ind==2%前进直行
    dvec = [step*cos(theta), step*sin(theta)];
    dx = now_point(1)+linspace(0,dvec(1),n2);
    dy = now_point(2)+linspace(0,dvec(2),n2);
    angle=linspace(theta,theta,n2);
    route=[dx' dy' angle'];
    x=dx(end);
    y=dy(end);
    sita=angle(end);
    for i=1:n2
        temp=route(i,1:2);
        for j=1:size(ob_coo)
            if norm(temp-ob_coo(j,:))<safe_dis+(2^0.5)/2
                isok=1;
                return
            end
        end
    end
elseif ind==3%前进右转
    cenx = now_point(1)+min_r*sin(theta);
    ceny = now_point(2)-min_r*cos(theta);
    t = theta+pi/2-linspace(0,step/min_r,n2);
    dx = cenx+min_r*cos(t);
    dy = ceny+min_r*sin(t);
    angle=t-pi/2;
    route=[dx' dy' angle'];
    x=dx(end);
    y=dy(end);
    sita=angle(end);
    for i=1:n2
        temp=route(i,1:2);
        for j=1:size(ob_coo)
            if norm(temp-ob_coo(j,:))<safe_dis+(2^0.5)/2
                isok=1;
                return
            end
        end
    end
% elseif ind==4%倒退左转
%     cenx = now_point(1)-min_r*sin(theta);
%     ceny = now_point(2)+min_r*cos(theta);
%     t = theta-pi/2-linspace(0,step/min_r,n2);
%     dx = cenx+min_r*cos(t);
%     dy = ceny+min_r*sin(t);
%     angle=t+pi/2;
%     route=[dx' dy' angle'];
%     x=dx(end);
%     y=dy(end);
%     sita=angle(end);
%     for i=1:n2
%         temp=route(i,1:2);
%         for j=1:size(ob_coo)
%             if norm(temp-ob_coo(j,:))<safe_dis+(2^0.5)/2
%                 isok=1;
%                 return
%             end
%         end
%     end  
% elseif ind==5%倒退直行
%     dvec = [step*cos(theta), step*sin(theta)];
%     dx = now_point(1)-linspace(0,dvec(1),n2);
%     dy = now_point(2)-linspace(0,dvec(2),n2);
%     angle=linspace(theta,theta,n2);
%     route=[dx' dy' angle'];
%     x=dx(end);
%     y=dy(end);
%     sita=angle(end);
%     for i=1:n2
%         temp=route(i,1:2);
%         for j=1:size(ob_coo)
%             if norm(temp-ob_coo(j,:))<safe_dis+(2^0.5)/2
%                 isok=1;
%                 return
%             end
%         end
%     end
% elseif ind==6%倒退右转
%     cenx = now_point(1)+min_r*sin(theta);
%     ceny = now_point(2)-min_r*cos(theta);
%     t = theta+pi/2+linspace(0,step/min_r,n2);
%     dx = cenx+min_r*cos(t);
%     dy = ceny+min_r*sin(t);
%     angle=t-pi/2;
%     route=[dx' dy' angle'];
%     x=dx(end);
%     y=dy(end);
%     sita=angle(end);
%     for i=1:n2
%         temp=route(i,1:2);
%         for j=1:size(ob_coo)
%             if norm(temp-ob_coo(j,:))<safe_dis+(2^0.5)/2
%                 isok=1;
%                 return
%             end
%         end
%     end
end

