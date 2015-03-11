function [u,v] = compute_gvf(f, mu, ITER)
[m,n] = size(f);
fmin  = min(f(:));fmax  = max(f(:));
f = (f-fmin)/(fmax-fmin); 
f = check(f,1);             % Take care of boundary condition
[fx,fy] = gradient(f);      % Calculate the gradient 
u = fx; v = fy;             % Initialize GVF to the gradient
for i=1:ITER,
  u = check(u,2); v = check(v,2);
  u = u + mu*4*del2(u) - (fx.*fx + fy.*fy).*(u-fx); % Solve iteratively the equations given in paper
  v = v + mu*4*del2(v) - (fx.*fx + fy.*fy).*(v-fy);
end
u = check(u,3); v = check(v,3);

