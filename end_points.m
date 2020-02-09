clear grid_x grid_y
A = imread('3.png');
A = rgb2gray(A);
A = imbinarize(A);
A = double(A);
IMG = bwareaopen(A,1000);
%imshow(A)
%imshow(IMG)
tol = 5;
[~,angle] = imgradient(IMG);
out = (angle >= 180 - tol | angle <= -180 + tol);
VER_LIN = bwareaopen(out, 30);
figure,imshow(VER_LIN),title('Detected Lines');

HOR = imrotate(IMG,-90);
[~,angle] = imgradient(HOR);
out = (angle >= 180 - tol | angle <= -180 + tol);
HOR_LIN = bwareaopen(out, 30);
HOR_LIN = imrotate(HOR_LIN,90);
figure,imshow(HOR_LIN),title('Detected Lines');
%imwrite(HOR_LIN,'HOR_LIN.jpg');
%imwrite(VER_LIN,'VER_LIN.jpg');
%cellArr = {IMG,VER_LIN,HOR_LIN};
%montage(cellArr)

BWH2 = bwmorph(HOR_LIN,'skel',inf);
BWH3 = bwmorph(BWH2,'endpoints');

%figure, imshow(BWH2)
figure, imshow(BWH3)
BWV2 = bwmorph(VER_LIN,'skel',inf);
BWV3 = bwmorph(BWV2,'endpoints');

%figure, imshow(BWV2)
figure, imshow(BWV3)
[yh, xh] = find(BWH3 > 0);
[yv, xv] = find(BWV3 > 0);
imwrite(BWH3,'HOR_PTS.jpg');
imwrite(BWV3,'VER_PTS.jpg');

yk = sort(yh);
l_yk = length(yk);

s = 1;
grid_y(1) = yk(1);
for i=1:l_yk-1
    if (yk(i+1)-yk(i)) > 10
        s = s + 1;
        grid_y(s) = yk(i+1);
    end
end

xk = sort(xv);
l_xk = length(xk);

s = 1;
grid_x(1) = xk(1);
for i=1:l_xk-1
    if (xk(i+1)-xk(i)) > 10
        s = s + 1;
        grid_x(s) = xk(i+1);
    end
end

hcor = [xh yh];
vcor = [xv yv];

[hsz,~] = size(xh);
[vsz,~] = size(xv);

for i=1:hsz
    for j=1:length(grid_x)
        if hcor(i,1)>= grid_x(j) - 10 && hcor(i,1)<= grid_x(j) + 10
            hcor(i,1) = grid_x(j);
            break;
        end
    end
end

for i=1:hsz
    for j=1:length(grid_y)
        if hcor(i,2)>= grid_y(j) - 10 && hcor(i,2)<= grid_y(j) + 10
            hcor(i,2) = grid_y(j);
            break;
        end
    end
end

for i=1:vsz
    for j=1:length(grid_y)
        if vcor(i,2)>= grid_y(j) - 10 && vcor(i,2)<= grid_y(j) + 10
            vcor(i,2) = grid_y(j);
            break;
        end
    end
end

for i=1:vsz
    for j=1:length(grid_x)
        if vcor(i,1)>= grid_x(j) - 10 && vcor(i,1)<= grid_x(j) + 10
            vcor(i,1) = grid_x(j);
            break;
        end
    end
end

xx = unique(hcor, 'rows');
yy = unique(vcor, 'rows');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CC_h = bwconncomp(HOR_LIN);
stats_h = regionprops(CC_h,'PixelList');

CC_v = bwconncomp(VER_LIN);
stats_v = regionprops(CC_v,'PixelList');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = length(stats_h);
zh = zeros(k,4);
for i = 1:k
    len = length(stats_h(i).PixelList);
    zh(i,1) = stats_h(i).PixelList(1,1);
    zh(i,2) = stats_h(i).PixelList(1,2);
    zh(i,3) = stats_h(i).PixelList(len,1);
    zh(i,4) = stats_h(i).PixelList(len,2);
end

len = length(xx);
for i = 1:len
    for j = 1:k
        if sqrt((((xx(i,1) - zh(j,1)).^2) + (xx(i,2) - zh(j,2)).^2)) < 12
            zh(j, 1) = xx(i, 1);
            zh(j, 2) = xx(i, 2);
        end
        if sqrt(((xx(i,1) - zh(j,3)).^2) + (xx(i,2) - zh(j,4)).^2) < 12
            zh(j, 3) = xx(i, 1);
            zh(j, 4) = xx(i, 2);
        end
    end
end
%disp(zh)

k1 = length(stats_v);
zv = zeros(k1, 4);
for i = 1:k1
    len = length(stats_v(i).PixelList);
    zv(i,1) = stats_v(i).PixelList(1,1);
    zv(i,2) = stats_v(i).PixelList(1,2);
    zv(i,3) = stats_v(i).PixelList(len,1);
    zv(i,4) = stats_v(i).PixelList(len,2);
end

len1 = length(yy);
for i = 1:len1
    for j = 1:k1
        if sqrt((((yy(i,1) - zv(j,1)).^2) + (yy(i,2) - zv(j,2)).^2)) < 12
            zv(j, 1) = yy(i, 1);
            zv(j, 2) = yy(i, 2);
        end
        if sqrt(((yy(i,1) - zv(j,3)).^2) + (yy(i,2) - zv(j,4)).^2) < 12
            zv(j, 3) = yy(i, 1);
            zv(j, 4) = yy(i, 2);
        end
    end
end
%disp(zv)
header = {'x1','y1','x2', 'y2'};

output = [header; num2cell(zv)];
output1 = [header; num2cell(zh)];

t1 = (length(grid_x)-1)*((length(grid_y)));
h_line = zeros(t1,4);
k=1;
for i=1:length(grid_x)-1
    for j=1:length(grid_y)
        h_line(k,:) = [grid_x(i),grid_y(j),grid_x(i+1),grid_y(j)];
        k=k+1;
    end
end

t2 = (length(grid_x))*((length(grid_y))-1);
v_line = zeros(t2,4);
m=1;
for i=1:length(grid_x)
    for j=1:length(grid_y)-1
        v_line(m,:) = [grid_x(i),grid_y(j), grid_x(i),grid_y(j+1)];
        m = m+1;
    end
end

n = length(zh)+1;
for i=1:length(grid_x)
    for j=1:length(zh)
        if grid_x(i)<zh(j,3) && grid_x(i)>zh(j,1)
            zh(n,:) = [zh(j,1), zh(j,2), grid_x(i), zh(j,4)];
            n=n+1;
            zh(n,:) = [grid_x(i), zh(j,2), zh(j,3) zh(j,4)];
            n=n+1;
        end
    end
end
zh = unique(zh, 'rows');

m = length(zv)+1;
for i=1:length(grid_y)
    for j=1:length(zv)
        if grid_y(i)<zv(j,4) && grid_y(i)>zv(j,2)
            zv(m,:) = [zv(j,1), zv(j,2), zv(j,3), grid_y(i)];
            m=m+1;
            zv(m,:) = [zv(j,1), grid_y(i), zv(j,3) zv(j,4)];
            m=m+1;
        end
    end
end
zv = unique(zv, 'rows');

ta = (length(grid_x)-1)*((length(grid_y)-1));
index=zeros(ta,4);
g=1;
l_h = zeros(ta,4);
l_v = zeros(ta,4);vc=1;hc=1;
l_n = zeros(ta,4); nc=1;
for i=1:length(grid_x)-1
    for j=1:length(grid_y)-1
        f1=0;f2=0;
        for p=1:length(zh)
            z=[grid_x(i),grid_y(j+1),grid_x(i+1),grid_y(j+1)];
            if z==zh(p,:)
                f1=1;
            end
        end
        for q=1:length(zv)
            w=[grid_x(i+1),grid_y(j),grid_x(i+1),grid_y(j+1)];
            if w==zv(q,:)
                f2=1;
            end
        end
        if f1==1 && f2==1
            xi=i; yi=j;
            xf=i+1; yf=j+1;
            index(g,:)=[xi,yi,xf,yf];
            g=g+1;
        end
        if f1==1 && f2==0
            l_v(vc,:) = [i,j,i+1,j+1];
            vc=vc+1;
        end
        if f1==0 && f2==1
            l_h(hc,:) = [i,j,i+1,j+1];
            hc=hc+1;
        end
        if f1==0 && f2==0
            l_n(nc,:) = [i,j,i+1,j+1];
            nc=nc+1;
        end
        if index(g,3)==length(grid_x) && index(g,4)==length(grid_y)
            break
        end
    end
end

index1 = zeros(g-1,4);b=1;
for i=1:ta
    if index(i,:)~=0
        index1(b,:) = index(i,:);
        b=b+1;
    end
end

l_h1 = zeros(hc-1,4);b=1;
for i=1:ta
    if l_h(i,:)~=0
        l_h1(b,:) = l_h(i,:);
        b=b+1;
    end
end

l_v1 = zeros(vc-1,4);b=1;
for i=1:ta
    if l_v(i,:)~=0
        l_v1(b,:) = l_v(i,:);
        b=b+1;
    end
end

l_n1 = zeros(nc-1,4);b=1;
for i=1:ta
    if l_n(i,:)~=0
        l_n1(b,:) = l_n(i,:);
        b=b+1;
    end
end

t1 = (length(grid_x)-1);
t2 = (length(grid_y)-1);
num = zeros(t2,t1);c=1; % num = encoded matrix
o1=size(index1);
o2=size(l_h1);
o3=size(l_v1);
o4=size(l_n1);
for i=1:length(grid_x)-1
    for j=1:length(grid_y)-1
        w1=[i,j,i+1,j+1];
        for p=1:o1(1)
            if w1==index1(p,:)
                num(j,i)=c;
                c=c+1;
            end
        end
        for q=1:o2(1)
            if w1==l_h1(q,:)
                num(j,i)=-1;
            end
        end
        for r=1:o3(1)
            if w1==l_v1(r,:)
                num(j,i)=-2;
            end
        end
        for s=1:o4(1)
            if w1==l_n1(s,:)
                num(j,i)=-3;
            end
        end
    end
end

h=0;v=0;n=0;
for i=1:length(grid_x)-1
    for j=1:length(grid_y)-1
        if num(j,i)==-1
            h=h+1;
        end
        if num(j,i)==-2
            v=v+1;
        end
        if num(j,i)==-3
            n=n+1;
        end
    end
    for k=1:h
        for j=1:length(grid_y)-1
            
            if num(j,i)==-1
                num(j,i)=num(j+1,i);
            end
        end
    end
end

for j=1:length(grid_y)-1
    
    for t=1:v
        
        for i=1:length(grid_x)-1
            if num(j,i)==-2
                num(j,i)=num(j,i+1);
            end
        end
    end
    for k=1:n
        for i=1:length(grid_x)-1
            
            if num(j,i)==-3
                num(j,i)=num(j,i+1);
            end
        end
    end
end

cor=zeros(ta,5);b=1;
for z=1:c-1
    for i=1:length(grid_x)-1
        for j=1:length(grid_y)-1
            if num(j,i)==z
                cor(b,:)=[i,j,i+1,j+1,z];
                b=b+1;
            end
        end
    end
end

s=1;
cor1=zeros(c-1,4);
cord=zeros(c-1,4);% coordinates of top-left and bottom-rigtht vertices of rectangles
for i=1:c-1
    for j=1:b-1
        if cor(j,5)==i
            cor1(s,:)=[cor(j,1), cor(j,2),0,0];
            cord(s,:)=[grid_x(cor(j,1)),grid_y(cor(j,2)),0,0];
            s=s+1;
            break
        end
    end
end

for i=1:s-1
    cor1(i,3)=index1(i,3);
    cord(i,3)=grid_x(index1(i,3));
    cor1(i,4)=index1(i,4);
    cord(i,4)=grid_y(index1(i,4));
end

dim=zeros(c-1,2); %dimensions = [height,width]
for i=1:s-1
    dim(i,1)=cord(i,4)-cord(i,2);
    dim(i,2)=cord(i,3)-cord(i,1);
end





