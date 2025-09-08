%% 可视化
figure
imshow(mapOriginal,'InitialMagnification','fit');

map = mapSafe;
image((map==0).*0 + (map==1).*255 + (mapResized-map).*150);
image((map==0).*255 + (map==1).*255 + (mapResized-map).*255);
pbaspect([1.12 1 1])

%% case 4
r1 = 1.5;
a1 = 23;
b1 = 32;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 13;
b1 = 24;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on 

r1 = 1.5;
a1 = 23;
b1 = 18;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 16;
b1 = 10;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 28;
b1 = 28;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 33;
b1 = 36;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 33;
b1 = 22;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 12;
b1 = 38;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 40;
b1 = 27;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 32;
b1 = 10;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 41;
b1 = 44;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

r1 = 1.5;
a1 = 5;
b1 = 7;
para = [a1-r1, b1-r1, 2*r1, 2*r1];
rectangle('Position', para, 'Curvature', [1 1],'FaceColor',[0.5, 0.5, 0.5]);
hold on

%% map_exp
% r1 = 2;
% r2 = 8;
% a1 = 21.5;
% b1 = 30;
% para = [a1-r1, b1-r1, r1, r2];
% rectangle('Position', para,'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 2;
% r2 = 8;
% a1 = 30;
% b1 = 30;
% para = [a1-r1, b1-r1, r1, r2];
% rectangle('Position', para,'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 4;
% r2 = 4;
% a1 = 38;
% b1 = 40;
% para = [a1-r1, b1-r1, r1, r2];
% rectangle('Position', para,'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 8;
% r2 = 2;
% a1 = 25;
% b1 = 29;
% para = [a1-r1, b1-r1, r1, r2];
% rectangle('Position', para,'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 4;
% r2 = 4;
% a1 = 38;
% b1 = 24;
% para = [a1-r1, b1-r1, r1, r2];
% rectangle('Position', para,'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 6;
% r2 = 6;
% a1 = 15;
% b1 = 40;
% para = [a1-r1, b1-r1, r1, r2];
% rectangle('Position', para,'FaceColor',[0.5, 0.5, 0.5]);
% hold on
% 
% r1 = 6;
% r2 = 6;
% a1 = 30;
% b1 = 12;
% para = [a1-r1, b1-r1, r1, r2];
% rectangle('Position', para,'FaceColor',[0.5, 0.5, 0.5]);
% hold on


%% draw
cmap = colormap(gray);  % 先获取默认灰度 colormap

colormap(cmap);  % 应用自定义 colormap
color = ['r','g','b','y','c','m','r','g','b','y','c','m'];
hold on
% 
for i = 1 : num
    z = swarm_path{i};
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
z = swarm_path;
for n = 1 : num
    [h1(n),h2(n)]=plot_car(z{n}(1,:),car_size);
    hold on
end
    l1 = line([z{1}(1,2),z{2}(1,2)],[z{1}(1,1),z{2}(1,1)],'color','k');
    l2 = line([z{2}(1,2),z{3}(1,2)],[z{2}(1,1),z{3}(1,1)],'color','k');
    l3 = line([z{3}(1,2),z{4}(1,2)],[z{3}(1,1),z{4}(1,1)],'color','k');
    l4 = line([z{4}(1,2),z{1}(1,2)],[z{4}(1,1),z{1}(1,1)],'color','k');
    l5 = line([z{5}(i,2),z{1}(i,2)],[z{5}(i,1),z{1}(i,1)],'color','k');
for i = 2 : H
    delete(h1)
    delete(h2)
    delete(l1)
    delete(l2)
    delete(l3)
    delete(l4)
    delete(l5)
    for n = 1 : num
        r_lin=z{n}(i,:);
        p = plot(z{n}(i-1:i,2),z{n}(i-1:i,1),'r-','LineWidth',2);
        % p = plot(z{n}(i-1:i,2),z{n}(i-1:i,1),'Color', color(n),'LineWidth',2);
        hold on
        [h1(n),h2(n)]=plot_car(r_lin,car_size);
        hold on
    end
    l1 = line([z{1}(i,2),z{2}(i,2)],[z{1}(i,1),z{2}(i,1)],'color','k');
    l2 = line([z{2}(i,2),z{3}(i,2)],[z{2}(i,1),z{3}(i,1)],'color','k');
    l3 = line([z{3}(i,2),z{4}(i,2)],[z{3}(i,1),z{4}(i,1)],'color','k');
    l4 = line([z{4}(i,2),z{5}(i,2)],[z{4}(i,1),z{5}(i,1)],'color','k');
    l5 = line([z{5}(i,2),z{1}(i,2)],[z{5}(i,1),z{1}(i,1)],'color','k');
        title('Planned UGV Trajectories (proposed)');
        xlabel('x(m)');
        ylabel('y(m)');
        set(gca,'TickDir','in')
        axis on
        switch num
            case 3
                legend([UGV(1),UGV(2),UGV(3)],'UGV1','UGV2','UGV3')
            case 4
                legend([UGV(1),UGV(2),UGV(3),UGV(4)],'UGV1','UGV2','UGV3','UGV4')
            case 5
                legend([UGV(1),UGV(2),UGV(3),UGV(4),UGV(5)],'UGV1','UGV2','UGV3','UGV4','UGV5')
            case 6
                legend([UGV(1),UGV(2),UGV(3),UGV(4),UGV(5),UGV(6)],'UGV1','UGV2','UGV3','UGV4','UGV5','UGV6')
        end
        drawnow;

    F=getframe(gcf);
    I=frame2im(F);
    [I,map]=rgb2ind(I,256);

    if pic_num == 1
    imwrite(I,map,'test_case5.gif','gif','Loopcount',inf,'DelayTime',0.2);

    else
    imwrite(I,map,'test_case5.gif','gif','WriteMode','append','DelayTime',0.2);
    end

    pic_num = pic_num + 1;
    pause(0.01);

end
    delete(h1)
    delete(h2)
    delete(l1)
    delete(l2)
    delete(l3)
    delete(l4)
    delete(l5)