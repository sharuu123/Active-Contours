function [xi,yi] = Interp(x,y,dmax,dmin)
x = x(:); y = y(:);
N = length(x);
d = abs(x([2:N 1])- x(:)) + abs(y([2:N 1])- y(:));
IDX = (d<dmin);
idx = find(IDX==0);
x = x(idx);
y = y(idx);
N = length(x);
d = abs(x([2:N 1])- x(:)) + abs(y([2:N 1])- y(:));
IDX = (d>dmax);
N1 = length(IDX);
z=1:0.5:N+0.5;
x1=1:N;
z(2*x1(IDX==0))=[];
p = 1:N+1;
xi = interp1(p,[x;x(1)],z');
yi = interp1(p,[y;y(1)],z');

N = length(xi);
d = abs(xi([2:N 1])- xi(:)) + abs(yi([2:N 1])- yi(:));
while (max(d)>dmax),
    IDX = (d>dmax);
    N1 = length(IDX);
    z=1:0.5:N+0.5;
    x1=1:N;
    z(2*x1(IDX==0))=[];
    p = 1:N+1;
    xi = interp1(p,[xi;xi(1)],z');
    yi = interp1(p,[yi;yi(1)],z');
    N = length(xi);
    d = abs(xi([2:N 1])- xi(:)) + abs(yi([2:N 1])- yi(:));
end
