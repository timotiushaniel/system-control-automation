%syms x(t)
%ode=diff(x,t) == x;
%ySol=dsolve(ode)
%ezplot(real(ySol(1)))

%syms x(t) a b
%eqn=diff(x,t,2)-x==0;
%dx=diff(x,t);
%cond = [x(0)==1, dx(0)==1];
%xSol(t)=dsolve(eqn, cond)
%ezplot(real(xSol(1)))

% syms x(t)
% eqn=diff(x,t)==cos(t);
% dx=diff(x,t);
% cond=[x(0)==1,dx(0)==1];
% xSol=dsolve(eqn, cond)1
% ezplot(real(xSol(1)))

syms x(t)
eqn=diff(x,t)==cos(x(t));
dx=diff(x,t);
cond=[x(0)==1];
xSol=dsolve(eqn, cond);

ezplot(real(xSol(1)),[0,10,-2,2]);