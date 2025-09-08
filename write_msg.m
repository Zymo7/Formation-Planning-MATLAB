%% 将位置坐标写入消息
function fsmsg = write_msg(cf_pos_2d,i,fsmsg)
fsmsg.X = cf_pos_2d(i,1);
fsmsg.Y = cf_pos_2d(i,2);
% fsmsg.Z = cf_pos_3d(i,3);
end