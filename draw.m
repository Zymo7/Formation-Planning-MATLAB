color = ['r','g','b','y','c','m','r','g','b','y','c','m'];

    hold off

%% 画动态图    
% pic_num = 1;
% R = R*size(mapOriginal,1)/resolutionX;
z = swarm_path;
for n = 1 : num
    z{n} = [(z{n}(:,1)*size(mapOriginal,1))/resolutionX (z{n}(:,2)*size(mapOriginal,2))/resolutionY z{n}(:,3)];
end
% for n = 1 : num
%     z{n}(:,3) = pi/2-z{n}(:,3);
% 
%     z{n}(1,3) = z{n}(1,3);
%     hold on
% end
car_size = [0.8 0.48 0.32];

figure

for i = 1 : H
    if i == 1
        tsubplot(2,2,1,'tight')
        imshow(mapOriginal,'InitialMagnification','fit');
        cmap = colormap(gray);  % 先获取默认灰度 colormap
        cmap(1, :) = [0.4, 0.4, 0.4];  % 将黑色（第1行）替换为灰色
        colormap(cmap);  % 应用自定义 colormap
        for n = 1 : num
            line( z{n}(:,2),z{n}(:,1));
            hold on
            plot( z{n}(1,2),z{n}(1,1) ,'o', 'Color', color(n), 'MarkerSize',4);
            hold on
            plot( z{n}(end,2),z{n}(end,1),'o', 'Color', color(n), 'MarkerSize',4);
            hold on
        end
        for n = 1 : num
            plot(z{n}(1:i,2),z{n}(1:i,1),'r-','LineWidth',2);
            hold on
            r_lin=z{n}(i,:);
            r_lin(3)=pi/2;
            hold on
            plot_car(r_lin,car_size);
            hold on
        end
        for n = 1 : num
            if n == num
                line([z{n}(i,2),z{1}(i,2)],[z{n}(i,1),z{1}(i,1)],'color','k','lineWidth',1,'linestyle','-');
            else
            line([z{n}(i,2),z{n+1}(i,2)],[z{n}(i,1),z{n+1}(i,1)],'color','k','lineWidth',1,'linestyle','-');
            end
        end
%         title('k=1');
        title('t=0s');
        xlabel('x(m)');
        ylabel('y(m)');
        set(gca,'TickDir','in')
        axis on
    end

    if i == round(H/3)
        tsubplot(2,2,2,'tight')
        legend off
        imshow(mapOriginal,'InitialMagnification','fit');
        cmap = colormap(gray);  % 先获取默认灰度 colormap
        cmap(1, :) = [0.4, 0.4, 0.4];  % 将黑色（第1行）替换为灰色
        colormap(cmap);  % 应用自定义 colormap
        for n = 1 : num
            line( z{n}(:,2),z{n}(:,1));
            hold on
            plot( z{n}(1,2),z{n}(1,1) ,'o', 'Color', color(n), 'MarkerSize',4);
            hold on
            plot( z{n}(end,2),z{n}(end,1),'o', 'Color', color(n), 'MarkerSize',4);
            hold on
        end
        for n = 1 : num
            plot(z{n}(1:i,2),z{n}(1:i,1),'r-','LineWidth',1);
            r_lin=z{n}(i,:);
            hold on
            plot_car(r_lin,car_size);
            hold on
        end
        for n = 1 : num
            if n == num
                line([z{n}(i,2),z{1}(i,2)],[z{n}(i,1),z{1}(i,1)],'color','k','lineWidth',1,'linestyle','-');
            else
            line([z{n}(i,2),z{n+1}(i,2)],[z{n}(i,1),z{n+1}(i,1)],'color','k','lineWidth',1,'linestyle','-');
            end
        end
%         title('k=H/3');
        title('t=22s');
        xlabel('x(m)');
        ylabel('y(m)');
        set(gca,'TickDir','in')
        axis on
    end

    if i == round(2*H/3)
        tsubplot(2,2,3,'tight')
        legend off
        imshow(mapOriginal,'InitialMagnification','fit');
        cmap = colormap(gray);  % 先获取默认灰度 colormap
        cmap(1, :) = [0.4, 0.4, 0.4];  % 将黑色（第1行）替换为灰色
        colormap(cmap);  % 应用自定义 colormap
        for n = 1 : num
            line( z{n}(:,2),z{n}(:,1));
            hold on
            plot( z{n}(1,2),z{n}(1,1) ,'o', 'Color', color(n), 'MarkerSize',4);
            hold on
            plot( z{n}(end,2),z{n}(end,1),'o', 'Color', color(n), 'MarkerSize',4);
            hold on
        end
        for n = 1 : num
            plot(z{n}(1:i,2),z{n}(1:i,1),'r-','LineWidth',1);
            r_lin=z{n}(i,:);
            hold on
            plot_car(r_lin,car_size);
            hold on
        end
        for n = 1 : num
            if n == num
                line([z{n}(i,2),z{1}(i,2)],[z{n}(i,1),z{1}(i,1)],'color','k','lineWidth',1,'linestyle','-');
            else
            line([z{n}(i,2),z{n+1}(i,2)],[z{n}(i,1),z{n+1}(i,1)],'color','k','lineWidth',1,'linestyle','-');
            end
        end
%         title('k=2H/3');
        title('t=44s');
        xlabel('x(m)');
        ylabel('y(m)');
        set(gca,'TickDir','in')
        axis on
    end

    if i == H
        tsubplot(2,2,4,'tight')
        legend off
        imshow(mapOriginal,'InitialMagnification','fit');
        cmap = colormap(gray);  % 先获取默认灰度 colormap
        cmap(1, :) = [0.4, 0.4, 0.4];  % 将黑色（第1行）替换为灰色
        colormap(cmap);  % 应用自定义 colormap
        for n = 1 : num
            line( z{n}(:,2),z{n}(:,1));
            hold on
            plot( z{n}(1,2),z{n}(1,1) ,'o', 'Color', color(n), 'MarkerSize',4);
            hold on
            plot( z{n}(end,2),z{n}(end,1),'o', 'Color', color(n), 'MarkerSize',4);
            hold on
        end
        for n = 1 : num
            plot(z{n}(1:i,2),z{n}(1:i,1),'r-','LineWidth',1);
            r_lin=z{n}(i,:);
            hold on
            plot_car(r_lin,car_size);
            hold on
        end
        for n = 1 : num
            if n == num
                line([z{n}(i,2),z{1}(i,2)],[z{n}(i,1),z{1}(i,1)],'color','k','lineWidth',1,'linestyle','-');
            else
            line([z{n}(i,2),z{n+1}(i,2)],[z{n}(i,1),z{n+1}(i,1)],'color','k','lineWidth',1,'linestyle','-');
            end
        end
%         title('k=H');
        title('t=66s');
        xlabel('x(m)');
        ylabel('y(m)');
        set(gca,'TickDir','in')
        axis on
    end

            legend on

            if num == 3
                legend('','UGV1','','','UGV2','','','UGV3','','Trajectories','','','','','','','','');
            elseif num == 4
                legend('','UGV1','','','UGV2','','','UGV3','','','UGV4','','Trajectories','','','','','','','');
            elseif num == 5
            legend('','UGV1','','','UGV2','','','UGV3','','','UGV4','','','UGV5','','Trajectories','','','','','','','');
            elseif num == 6
                legend('','UGV1','','','UGV2','','','UGV3','','','UGV4','','','UGV5','','','UGV6','','Trajectories','','','','','','','');
            end
%     drawnow;
% 
%     F=getframe(gcf);
%     I=frame2im(F);
%     [I,map]=rgb2ind(I,256);
% 
%     if pic_num == 1
%     imwrite(I,map,'test.gif','gif','Loopcount',inf,'DelayTime',0.2);
% 
%     else
%     imwrite(I,map,'test.gif','gif','WriteMode','append','DelayTime',0.2);
%     end
% 
%     if i == 1
%         imwrite(I,map,'1.png');
%     end
% 
%     if i == 16        
%         imwrite(I,map,'H3.png');
%     end
% 
%     if i == 32
%         imwrite(I,map,'2H3.png');
%     end
% 
%     if i == H
%         imwrite(I,map,'H.png');
%     end
% 
%     pic_num = pic_num + 1;
%     pause(0.1);

end