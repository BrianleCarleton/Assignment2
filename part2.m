clearvars; close all
set(0,'DefaultFigureWindowStyle','docked')
nx = 60;
ny = 60;
F = zeros(1,nx*ny);
G = sparse(ny*nx);
M = zeros(nx,ny);
L = 90e-9;
W = 60e-9;
sigma = ones(nx,ny);
x = linspace(0,L,nx);
y = linspace(0,W,ny);
   

for i = 1:nx
   for j = 1:ny
    if x(i)> L*0.3 & x(i)< L*0.6 & (y(j)< W*0.15 | y(j)> W*0.8)
        sigma(i,j) = 10e-2;
    end
   end
end

    

for i = 1:nx 
        for j = 1:ny
        n = j +(i-1)*ny;
        nxm = j + (i-2)*ny;
        nxp = j + (i)*ny;
        nyp = (j+1) + (i-1)*ny; 
        nym = (j-1) +(i-1)*ny;
        
            if i == 1
            G(n,n) = sigma(i,j);
            F(n) = 1;
            
            elseif i == nx
            G(n,n) = sigma(i,j);   
            
            elseif j == 1 %bottom   
            G(n,nxp) = sigma(i+1,j);
            G(n,nxm) = sigma(i-1,j);
            G(n,nyp) = sigma(i,j+1);
            G(n,n) = -(G(n,nxp)+G(n,nxm)+G(n,nyp));
            
            elseif j == ny %top
            G(n,nxp) = sigma(i+1,j);
            G(n,nxm) = sigma(i-1,j);
            G(n,nym) = sigma(i,j-1);
            G(n,n) = -(G(n,nxp)+G(n,nxm)+G(n,nym));
          
            else 
            G(n,nxp) = sigma(i+1,j);
            G(n,nxm) = sigma(i-1,j);
            G(n,nym) = sigma(i,j-1);
            G(n,nyp) = sigma(i,j+1);
            G(n,n) = -(G(n,nxp)+G(n,nxm)+G(n,nym)+G(n,nyp));
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
    
[Ex,Ey] = gradient(M);
E = sqrt((Ex^2)+(Ey^2));   
J = sigma.*E;


    
    
    
    
    

    
    
    
    
