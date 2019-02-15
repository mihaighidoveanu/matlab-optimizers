x0 = [0 0]';
% callFminunc(x0);

% % % % % % % % minimizare cu conditii
x0=[-1,1];
% callFmincon(x0);

% Exemplul 1.6 ~ Regresie liniara
x0=[-1,-2,0.5];
% callFmincon(x0);

% Exemplul 1.7 - Polinom stabil
x0=[1.4 0.85 1000];
% callFmincon(x0)

%f fmincon
%f fminunc
%f linprog

% Exemplul 1.8 - Programare liniara 

c=[1 -1 0 0.1 -5 2 0 -1 -0.5];
A1=[ones(1,3) zeros(1,6);...
zeros(1,3) ones(1,3) zeros(1,3);...
zeros(1,6) ones(1,3)];
A2=[eye(3) eye(3) eye(3)];
C = [A1; A2; -eye(9)]; d= [ones(6,1);zeros(9,1)];
[x f] = linprog(c,C,d);


% % PDF1 - Programare liniara, patratica + Gradient, Hessiana, Jacobiana,
% monomiala, Liepschitz
% % PDF2 - Programare convexa + tare convexa, Inegalitatea Jensen, CVX, Proiectii,
% con Laurentz / auto-dual, functia conjugata, complementul Schur
% CVX basics - http://cvxr.com/cvx/doc/basics.html
% % PDF3 - UNLP (Unconstrained nonlinear programming)

% % Exemplu CVX
% m = 10; n = 8; p = 2;
% A = randn(m,n); b = randn(m,1);
% C = randn(p,n); d = randn(p,1);
% cvx_begin
%     variable x(n)
%     minimize(norm(A*x - b, 2))
%     subject to
%         C*x == d
%         norm(x, Inf) <= 1
% cvx_end

% Exemplu 2.13 - Raza unei bile
% Generare date de intrare
a1 = [ 2; 1]; a2 = [ 2; -1]; a3 = [-1; 2];
a4 = [-1; -2]; b = ones(4,1);
% Crearea si rezolvarea problemei de optimizare
cvx_begin
    variable r(1)
    variable x_c(2)
    maximize ( r )
    a1' * x_c + r * norm(a1,2) <= b(1);
    a2' * x_c + r * norm(a2,2) <= b(2);
    a3' * x_c + r * norm(a3,2) <= b(3);
    a4' * x_c + r * norm(a4,2) <= b(4);
cvx_end
% Generare figura
x = linspace(-2,2);
theta = 0:pi/100:2*pi;
plot( x, -x*a1(1)./a1(2) + b(1)./a1(2),'b-');
hold on
plot( x, -x*a2(1)./a2(2) + b(2)./a2(2),'b-');
plot( x, -x*a3(1)./a3(2) + b(3)./a3(2),'b-');
plot( x, -x*a4(1)./a4(2) + b(4)./a4(2),'b-');
plot( x_c(1) + r*cos(theta), x_c(2) + r*sin(theta), 'r');
plot(x_c(1),x_c(2),'k+'); xlabel('x_1'); ylabel('x_2');
title('Bila de raza maxima inscrisa intr-un poliedru 2D');
axis([-1 1 -1 1]); axis equal;

% % Exemplul 14
n = 20; m = 15*n;
w = linspace(0,pi,m)'; % omega
% Construim un raspuns in frecventa dorit
D = 8.25; % valoare intarziere
Hdes = exp(-j*D*w); % raspuns in frecventa dorit
% Filtru Gaussian cu faza liniara (decomentati liniile
% de mai jos pentru proiectare)
% var = 0.05;
% Hdes = 1/(sqrt(2*pi*var))*exp(-(w-pi/2).^2/(2*var));
% Hdes = Hdes.*exp(-j*n/2*w);
% Rezolvam problema minimax de proiectare a filtrului
% A reprezinta matricea folosita la calculul
% raspunsului in frecventa
% A(w,:) = [1 exp(-j*w) exp(-j*2*w) ... exp(-j*n*w)]
A = exp( -j*kron(w,[0:n-1]) );
% formularea optimala a filtrului Chebyshev
cvx_begin
    variable h(n,1)
    minimize( max( abs( A*h - Hdes ) ) )
cvx_end
% verificam daca problema a fost rezolvata cu succes
disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
h = [];
end
% Generam figurile aferente filtrului
figure(1); stem([0:n-1],h); xlabel('n'); ylabel('h(n)');
% figura raspunsului in frecventa
H = [exp(-j*kron(w,[0:n-1]))]*h;
figure(2)
% magnitudine
subplot(2,1,1);
plot(w,20*log10(abs(H)),w,20*log10(abs(Hdes)),'--');
xlabel('w'); ylabel('mag H in dB'); axis([0 pi -30 10]);
legend('optimizat','dorit','Location','SouthEast')
% faza
subplot(2,1,2); plot(w,angle(H));
axis([0,pi,-pi,pi]); xlabel('w'), ylabel('faza H(w)');
