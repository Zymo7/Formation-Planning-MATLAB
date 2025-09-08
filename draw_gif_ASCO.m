load ASCO_traj3.mat

%% 可视化
figure
imshow(mapOriginal,'InitialMagnification','fit');

map = mapSafe;
image((map==0).*255 + (map==1).*255 + (mapResized-map).*255);
pbaspect([1.12 1 1])

%% map_new_circle 对应ASCO_traj2 从左边过
% r1 = 2;
% a1 = 27.5;
% b1 = 22;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 5;
% a1 = 14;
% b1 = 22;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 5;
% a1 = 38;
% b1 = 22;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);

%% map_new_circle1 对应ASCO_traj1 从两边过
% r1 = 2;
% a1 = 24;
% b1 = 23;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 5;
% a1 = 12;
% b1 = 23;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 5;
% a1 = 36;
% b1 = 23;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);

%% map_task 对应traj3
r1 = 2;
a1 = 20;
b1 = 31;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 2;
a1 = 30;
b1 = 31;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on 

r1 = 2;
a1 = 28;
b1 = 24;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 2;
a1 = 16;
b1 = 25;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 2;
a1 = 19;
b1 = 18;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

%% map_dense50 (case4)
% r1 = 1.5;
% a1 = 23;
% b1 = 32;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 13;
% b1 = 24;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on 
% 
% r1 = 1.5;
% a1 = 23;
% b1 = 18;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 16;
% b1 = 10;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 28;
% b1 = 28;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 33;
% b1 = 36;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 33;
% b1 = 22;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 12;
% b1 = 38;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 40;
% b1 = 27;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 32;
% b1 = 10;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 41;
% b1 = 44;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 1.5;
% a1 = 5;
% b1 = 7;
% para = [a1-r1, b1-r1, 2*r1, 2*r1];
% rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);

cmap = colormap(gray);  % 先获取默认灰度 colormap

colormap(cmap);  % 应用自定义 colormap
color = ['r','g','b','y','c','m','r','g','b','y','c','m'];
hold on

for i = 1 : num
    z = traj{i};
    l = line(z(:,2),z(:,1));
    hold on
    UGV(i) = plot( z(1,2),z(1,1) ,'o', 'Color', color(i));
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
z = traj;
for n = 1 : num
    [h1(n),h2(n)]=plot_car(z{n}(1,:),car_size);
    hold on
end
    l1 = line([z{1}(1,2),z{2}(1,2)],[z{1}(1,1),z{2}(1,1)],'color','k');
    l2 = line([z{2}(1,2),z{3}(1,2)],[z{2}(1,1),z{3}(1,1)],'color','k');
    l3 = line([z{3}(1,2),z{4}(1,2)],[z{3}(1,1),z{4}(1,1)],'color','k');
    l4 = line([z{4}(1,2),z{1}(1,2)],[z{4}(1,1),z{1}(1,1)],'color','k');
for i = 2 : 2 : size(traj{1},1)
    delete(h1)
    delete(h2)
    delete(l1)
    delete(l2)
    delete(l3)
    delete(l4)
    for n = 1 : num
        r_lin=z{n}(i,:);
        if i < size(traj{1},1)
            p = plot(z{n}(i-1:i+1,2),z{n}(i-1:i+1,1),'r-','LineWidth',2);
        end
        hold on
        [h1(n),h2(n)]=plot_car(r_lin,car_size);
        hold on
    end
    l1 = line([z{1}(i,2),z{2}(i,2)],[z{1}(i,1),z{2}(i,1)],'color','k');
    l2 = line([z{2}(i,2),z{3}(i,2)],[z{2}(i,1),z{3}(i,1)],'color','k');
    l3 = line([z{3}(i,2),z{4}(i,2)],[z{3}(i,1),z{4}(i,1)],'color','k');
    l4 = line([z{4}(i,2),z{1}(i,2)],[z{4}(i,1),z{1}(i,1)],'color','k');
        title('Planned UGV Trajectories (Comparison)');
        xlabel('x(m)');
        ylabel('y(m)');
        set(gca,'TickDir','in')
        axis on
        switch num
            case 3
                legend([UGV(1),UGV(2),UGV(3)],'UGV1','UGV2','UGV3')
            case 4
                legend([UGV(1),UGV(2),UGV(3),UGV(4)],'UGV1','UGV2','UGV3','UGV4')
            case 6
                legend([UGV(1),UGV(2),UGV(3),UGV(4),UGV(5),UGV(6)],'UGV1','UGV2','UGV3','UGV4','UGV5','UGV6')
        end
        drawnow;

    F=getframe(gcf);
    I=frame2im(F);
    [I,map]=rgb2ind(I,256);

    if pic_num == 1
    imwrite(I,map,'test_ASCO_case3.gif','gif','Loopcount',inf,'DelayTime',0.2);

    else
    imwrite(I,map,'test_ASCO_case3.gif','gif','WriteMode','append','DelayTime',0.2);
    end

    pic_num = pic_num + 1;
    pause(0.001);
    
end
    delete(h1)
    delete(h2)
    delete(l1)
    delete(l2)
    delete(l3)
    delete(l4)