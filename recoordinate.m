aa = zeros(H,3*num);
uu = zeros(H,3*num);
pp = zeros(H,3*num);

for n = 1 : num
    for i = 1 : H
        pp(i,3*n-1) = row - p(i,2*n-1);
        pp(i,3*n-2) = p(i,2*n);
        pp(i,3*n) = 1;
    end
end

for n = 1 : num
    for i = 1 : H
        uu(i,3*n-2) = -u(i,2*n);
        uu(i,3*n-1) = u(i,2*n-1);
        uu(i,3*n) = 0;
    end
end

for n = 1 : num
    for i = 1 : H
        aa(i,3*n-2) = -a(i,2*n);
        aa(i,3*n-1) = a(i,2*n-1);
        aa(i,3*n) = 0;
    end
end

save aa.mat aa
save uu.mat uu
save pp.mat pp