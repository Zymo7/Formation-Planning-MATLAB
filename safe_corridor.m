% function safe_corridor = safe_corridor(resolutionX,resolutionY, map, mapOriginal, mapResized, mapSafe, path)
% 
%     [row, col] = size(mapResized);
%     [num, ~] = size(path);
%     safe_corridor = zeros(num,4);
%     left = 0;
%     right = 0;
%     up = 0;
%     down = 0;
% 
%     figure
%     imshow(mapOriginal, 'InitialMagnification', 'fit');
%     path_original = [(path(:,1)*size(mapOriginal,1))/resolutionX (path(:,2)*size(mapOriginal,2))/resolutionY];
%     line(path_original(:,2),path_original(:,1), 'Marker','.');
%     hold on
% 
%     for i = 1 : num
%         x = path(i, 2);
%         y = path(i, 1);
% 
%         if x > left && x < right && y > up && y < down && num <= 20
%             safe_corridor(i,1) = up;
%             safe_corridor(i,2) = down;
%             safe_corridor(i,3) = left;
%             safe_corridor(i,4) = right;
%             continue;
%         end
% 
%         % 初始化走廊边界为当前点位置
%         left = x;
%         right = x;
%         up = y;
%         down = y;
% 
%         % 扩张安全走廊
%         while (true)
%             leftPossible = 0;
%             rightPossible = 0;
%             upPossible = 0;
%             downPossible = 0;
% 
%             % 判断四个方向是否可以进行扩张
%             if left > 1 && left < col
%                 leftPossible = left > 1 && all(mapSafe(round(up):round(down), round(left - 1)) == 1);
%             end
%             if right > 1 && right < col-1
%                 rightPossible = right < col && all(mapSafe(round(up):round(down), round(right + 1)) == 1);
%             end
%             if up > 1 && up < row
%                 upPossible = up > 1 && all(mapSafe(round(up - 1), round(left):round(right)) == 1);
%             end
%             if down > 1 && down < row-1
%                 downPossible = down < row && all(mapSafe(round(down + 1), round(left):round(right)) == 1);
%             end
% 
%             % 如果没有可以扩张的方向，则退出循环
%             if ~(leftPossible || rightPossible || upPossible || downPossible)
%                 break;
%             end
% 
%             % 进行扩张
%             if leftPossible && left > 1 && left < col
%                 left = left - 1;
%             end
% 
%             if rightPossible && right > 1 && right < col
%                 right = right + 1;
%             end
% 
%             if upPossible && up > 1 && up < row
%                 up = up - 1;
%             end
% 
%             if downPossible && down > 1 && down < row
%                 down = down + 1;
%             end
%         end
% 
%         % 画出安全走廊，重叠部分颜色加深
% 
% %         v = [round(left)+1,round(up)+1; round(right),round(up)+1; round(right),round(down); round(left)+1,round(down);];
% %         v(:,1) = v(:,1)*size(mapOriginal,1)/resolutionX;
% %         v(:,2) = v(:,2)*size(mapOriginal,2)/resolutionY;
% %         f = [1,2,3,4];
% %         patch('Faces',f,'Vertices',v,'FaceColor','b','FaceAlpha',0.1);
% %         plot(path_original(i,2), path_original(i,1), 'Color', 'r', 'Marker', 'o')
% %         pause(0.1)
% % %         title('Safe Corridor Construction');
% %         title('安全走廊构建');
% %         xlabel('x(m)');
% %         ylabel('y(m)');
% %         set(gca,'TickDir','in')
% %         axis on
% 
%         safe_corridor(i,1) = up;
%         safe_corridor(i,2) = down;
%         safe_corridor(i,3) = left;
%         safe_corridor(i,4) = right;
%     end
%     hold off;
% end


function safe_corridor = safe_corridor(resolutionX,resolutionY, map, mapOriginal, mapResized, mapSafe, mapDense, path)

    [row, col] = size(mapResized);
    [num, ~] = size(path);
    safe_corridor = zeros(num,4);
    left = 0;
    right = 0;
    up = 0;
    down = 0;
      
    figure
    imshow(mapDense, 'InitialMagnification', 'fit');
    path_original = [(path(:,1)*10*size(mapOriginal,1))/resolutionX (path(:,2)*10*size(mapOriginal,2))/resolutionY];
    line(path_original(:,2),path_original(:,1), 'Marker','.');
    hold on

    %% 使用加密的地图进行安全走廊生成，得到的边界是小数，更加精确
    [row, col] = size(mapDense);
    mapSafe = mapDense;
   
    for i = 1 : num
        x = path_original(i, 2);
        y = path_original(i, 1);

        % if x > left && x < right && y > up && y < down && num <= 20
        %     safe_corridor(i,1) = up;
        %     safe_corridor(i,2) = down;
        %     safe_corridor(i,3) = left;
        %     safe_corridor(i,4) = right;
        %     continue;
        % end
        
        % 初始化走廊边界为当前点位置
        left = x;
        right = x;
        up = y;
        down = y;
        
        % 扩张安全走廊
        while (true)
            leftPossible = 0;
            rightPossible = 0;
            upPossible = 0;
            downPossible = 0;

            % 判断四个方向是否可以进行扩张
            if left > 1.5 && left < col
                leftPossible = left > 1 && all(mapSafe(round(up):round(down), round(left - 1)) == 1);
            end
            if right > 1.5 && right < col-1
                rightPossible = right < col && all(mapSafe(round(up):round(down), round(right + 1)) == 1);
            end
            if up > 1.5 && up < row
                upPossible = up > 1 && all(mapSafe(round(up - 1), round(left):round(right)) == 1);
            end
            if down > 1.5 && down < row-1
                downPossible = down < row && all(mapSafe(round(down + 1), round(left):round(right)) == 1);
            end

            % 如果没有可以扩张的方向，则退出循环
            if ~(leftPossible || rightPossible || upPossible || downPossible)
                break;
            end

            % 进行扩张
            if leftPossible && left > 1 && left < col
                left = left - 1;
            end

            if rightPossible && right > 1 && right < col
                right = right + 1;
            end

            if upPossible && up > 1 && up < row
                up = up - 1;
            end

            if downPossible && down > 1 && down < row
                down = down + 1;
            end
        end

        % 画出安全走廊，重叠部分颜色加深

%         v = [round(left)+1,round(up)+1; round(right),round(up)+1; round(right),round(down); round(left)+1,round(down);];
%         v(:,1) = v(:,1)*size(mapOriginal,1)/resolutionX;
%         v(:,2) = v(:,2)*size(mapOriginal,2)/resolutionY;
%         f = [1,2,3,4];
%         p = patch('Faces',f,'Vertices',v,'FaceColor','b','FaceAlpha',0.1);
%         plot(path_original(i,2), path_original(i,1), 'Color', 'r', 'Marker', 'o')
%         pause(0.1)
%         delete(p);
%         title('Safe Corridor Construction');
% %         title('安全走廊构建');
%         xlabel('x(m)');
%         ylabel('y(m)');
%         set(gca,'TickDir','in')
%         axis on

%% /10为了恢复正常尺度
        safe_corridor(i,1) = up/10;
        safe_corridor(i,2) = down/10;
        safe_corridor(i,3) = (left+5)/10;
        safe_corridor(i,4) = right/10;
    end
    % hold off;
end