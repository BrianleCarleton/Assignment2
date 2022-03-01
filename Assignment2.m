clearvars; close all
set(0,'DefaultFigureWindowStyle','docked')
nx = 20;
ny = 30;
F = zeros(1,nx*ny);
G = sparse(ny*nx);
M = zeros(nx,ny);
L = 90e-9;
W = 60e-9;
    for i = 1:nx 
        for j = 1:ny
        n = j +(i-1)*ny;
        nxm = j + (i-2)*ny;
        nxp = j + (i)*ny;
        nyp = (j+1) + (i-1)*ny; 
        nym = (j-1) +(i-1)*ny;
        
            if i == 1
            G(n,n) = 1;
            F(n) = 1;
            elseif i == nx
            G(n,n) = 1;
            %F(n) = 1; 
            elseif j == 1 %bottom   
            %G(n,n) = 1;
            G(n,nxp) = 1;
            G(n,nxm) = 1;
            G(n,nyp) = 1;
            G(n,n) = -(G(n,nxp)+G(n,nxm)+G(n,nyp));
            
            elseif j == ny %top
            G(n,nxp) = 1;
            G(n,nxm) = 1;
            G(n,nym) = 1;
            %G(n,n) = 1;
            G(n,n) = -(G(n,nxp)+G(n,nxm)+G(n,nym));
            else 
            G(n,n) = -4;
            G(n,nxp) = 1;
            G(n,nxm) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
            end           
        end
    end    
V = G\F';


    for i = 1:nx
        for j = 1:ny
            n = j + (i-1)*ny;
            M(i,j) = V(n);
        end
        surf(M,'linestyle','none')  
      
    end



    
 
% x = linspace(-L/2,L/2,nx);
% y = linspace(0,W,ny);
% a = W;
% b = L/2;
% 
% 
% V2sum = zeros(nx,ny);
% 
% for n = 1:2:200
%     V2 = zeros(nx,ny);
%     for i = 1:nx 
%         for j = 1:ny
% V2(i,j) = (4/pi)*(1/n)*(cosh((n*pi*x(i))/a)/cosh((n*pi*b)/a))*sin((n*pi*y(j))/a);
% 
%         end
%     end
%   V2sum = V2sum + V2;  
%   surf(V2sum)
%   pause(0.1)
% end
    


    
    
    
    
