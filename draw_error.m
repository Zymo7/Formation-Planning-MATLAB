% figure
% 
% for i = 1 : H
%     e_pos12(i) = norm( z{1}(i,1:2) - z{2}(i,1:2) ) - norm(des(1,:) - des(2,:))*size(mapOriginal,1)/resolutionX;
%     e_pos13(i) = norm( z{1}(i,1:2) - z{3}(i,1:2) ) - norm(des(1,:) - des(3,:))*size(mapOriginal,1)/resolutionX;
%     e_pos23(i) = norm( z{2}(i,1:2) - z{3}(i,1:2) ) - norm(des(2,:) - des(3,:))*size(mapOriginal,1)/resolutionX;
% end
% tsubplot(2,1,1,'tight')
% plot(e_pos12,'r')
% hold on
% plot(e_pos13,'g')
% hold on
% plot(e_pos23,'b')
% legend('UGV1&2','UGV1&3','UGV2&3')
% xlabel('k')
% ylabel('position error(m)')
% xlim([1,H])
% ylim([-2,2])
% title('Formation position error of three UGVs')
% 
% tsubplot(2,1,2,'tight')
% for i = 1 : H
%     e_ang12(i) = atan2( (z{1}(i,1) - z{2}(i,1)), (z{1}(i,2) - z{2}(i,2)) ) - (pi/2 - dir(i)) - atan2(des(1,1) - des(2,1),des(1,2) - des(2,2));
%     e_ang13(i) = atan2( (z{1}(i,1) - z{3}(i,1)), (z{1}(i,2) - z{3}(i,2)) ) - (pi/2 - dir(i)) - atan2(des(1,1) - des(3,1),des(1,2) - des(3,2));
%     e_ang23(i) = atan2( (z{2}(i,1) - z{3}(i,1)), (z{2}(i,2) - z{3}(i,2)) ) - (pi/2 - dir(i)) - atan2(des(2,1) - des(3,1),des(2,2) - des(3,2));
% end
% plot(e_ang12*180/pi,'r')
% hold on
% plot(e_ang13*180/pi,'g')
% hold on
% plot(e_ang23*180/pi,'b')
% legend('UGV1&2','UGV1&3','UGV2&3')
% xlabel('k')
% ylabel('angle error(degree)')
% xlim([1,H])
% ylim([-60,60])

figure

for i = 1 : H
    e_pos12(i) = norm( z{1}(i,1:2) - z{2}(i,1:2) ) - norm(des(1,:) - des(2,:))*size(mapOriginal,1)/resolutionX;
    e_pos13(i) = norm( z{1}(i,1:2) - z{3}(i,1:2) ) - norm(des(1,:) - des(3,:))*size(mapOriginal,1)/resolutionX;
    e_pos23(i) = norm( z{2}(i,1:2) - z{3}(i,1:2) ) - norm(des(2,:) - des(3,:))*size(mapOriginal,1)/resolutionX;
end
tsubplot(2,1,1,'tight')
plot(e_pos12,'r')
hold on
plot(e_pos13,'g')
hold on
plot(e_pos23,'b')
legend('UGV1&2','UGV1&3','UGV2&3')
xlabel('t(s)')
ylabel('position error(m)')
xlim([1,H])
ylim([-2,2])
title('Formation error')

tsubplot(2,1,2,'tight')
for i = 1 : H
    e_ang12(i) = atan2( (z{1}(i,1) - z{2}(i,1)), (z{1}(i,2) - z{2}(i,2)) ) - (pi/2 - dir(i)) - atan2(des(1,1) - des(2,1),des(1,2) - des(2,2));
    e_ang13(i) = atan2( (z{1}(i,1) - z{3}(i,1)), (z{1}(i,2) - z{3}(i,2)) ) - (pi/2 - dir(i)) - atan2(des(1,1) - des(3,1),des(1,2) - des(3,2));
    e_ang23(i) = atan2( (z{2}(i,1) - z{3}(i,1)), (z{2}(i,2) - z{3}(i,2)) ) - (pi/2 - dir(i)) - atan2(des(2,1) - des(3,1),des(2,2) - des(3,2));
end
plot(e_ang12*180/pi,'r')
hold on
plot(e_ang13*180/pi,'g')
hold on
plot(e_ang23*180/pi,'b')
legend('UGV1&2','UGV1&3','UGV2&3')
xlabel('t(s)')
ylabel('angle error(degree)')
xlim([1,H])
ylim([-60,60])