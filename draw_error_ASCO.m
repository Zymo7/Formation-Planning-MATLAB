figure
z = traj;
for i = 1 : size(z{1},1)
    e_pos12(i) = norm( z{1}(i,1:2) - z{2}(i,1:2) ) - norm(des(1,:) - des(2,:))*size(mapOriginal,1)/resolutionX;
    e_pos13(i) = norm( z{1}(i,1:2) - z{3}(i,1:2) ) - norm(des(1,:) - des(3,:))*size(mapOriginal,1)/resolutionX;
    e_pos14(i) = norm( z{1}(i,1:2) - z{4}(i,1:2) ) - norm(des(1,:) - des(4,:))*size(mapOriginal,1)/resolutionX;
    e_pos23(i) = norm( z{2}(i,1:2) - z{3}(i,1:2) ) - norm(des(2,:) - des(3,:))*size(mapOriginal,1)/resolutionX;
    e_pos24(i) = norm( z{2}(i,1:2) - z{4}(i,1:2) ) - norm(des(2,:) - des(4,:))*size(mapOriginal,1)/resolutionX;
    e_pos34(i) = norm( z{3}(i,1:2) - z{4}(i,1:2) ) - norm(des(3,:) - des(4,:))*size(mapOriginal,1)/resolutionX;
end
subplot(2,1,1)
plot(e_pos12)
hold on
plot(e_pos13)
hold on
plot(e_pos14)
hold on
plot(e_pos23)
hold on
plot(e_pos24)
hold on
plot(e_pos34)
legend('UAV1&2','UAV1&3','UAV1&4','UAV2&3','UAV2&4','UAV3&4')
xlabel('k','FontSize',12)
ylabel('position error(m)','FontSize',12)
xlim([1,size(z{1},1)])
ylim([-5,5])
title('Formation error','FontSize',14)

poserr_mean12 = sum(abs(e_pos12))/size(e_pos12,2)
poserr_mean13 = sum(abs(e_pos13))/size(e_pos13,2)
poserr_mean14 = sum(abs(e_pos14))/size(e_pos14,2)
poserr_mean23 = sum(abs(e_pos23))/size(e_pos23,2)
poserr_mean24 = sum(abs(e_pos24))/size(e_pos24,2)
poserr_mean34 = sum(abs(e_pos34))/size(e_pos34,2)

subplot(2,1,2)
zz = swarm_path;

for i = 1 : H
    ee_pos12(i) = norm( zz{1}(i,1:2) - zz{2}(i,1:2) ) - norm(des(1,:) - des(2,:))*size(mapOriginal,1)/resolutionX;
    ee_pos13(i) = norm( zz{1}(i,1:2) - zz{3}(i,1:2) ) - norm(des(1,:) - des(3,:))*size(mapOriginal,1)/resolutionX;
    ee_pos14(i) = norm( zz{1}(i,1:2) - zz{4}(i,1:2) ) - norm(des(1,:) - des(4,:))*size(mapOriginal,1)/resolutionX;
    ee_pos23(i) = norm( zz{2}(i,1:2) - zz{3}(i,1:2) ) - norm(des(2,:) - des(3,:))*size(mapOriginal,1)/resolutionX;
    ee_pos24(i) = norm( zz{2}(i,1:2) - zz{4}(i,1:2) ) - norm(des(2,:) - des(4,:))*size(mapOriginal,1)/resolutionX;
    ee_pos34(i) = norm( zz{3}(i,1:2) - zz{4}(i,1:2) ) - norm(des(3,:) - des(4,:))*size(mapOriginal,1)/resolutionX;
end
plot(ee_pos12)
hold on
plot(ee_pos13)
hold on
plot(ee_pos14)
hold on
plot(ee_pos23)
hold on
plot(ee_pos24)
hold on
plot(ee_pos34)
legend('UAV1&2','UAV1&3','UAV1&4','UAV2&3','UAV2&4','UAV3&4')
xlabel('k','FontSize',12)
ylabel('position error(m)','FontSize',12)
xlim([1,H])
ylim([-5,5])
title('Formation error','FontSize',14)

poserr_mean12 = sum(abs(e_pos12))/size(ee_pos12,2)
poserr_mean13 = sum(abs(e_pos13))/size(ee_pos13,2)
poserr_mean14 = sum(abs(e_pos14))/size(ee_pos14,2)
poserr_mean23 = sum(abs(e_pos23))/size(ee_pos23,2)
poserr_mean24 = sum(abs(e_pos24))/size(ee_pos24,2)
poserr_mean34 = sum(abs(e_pos34))/size(ee_pos34,2)