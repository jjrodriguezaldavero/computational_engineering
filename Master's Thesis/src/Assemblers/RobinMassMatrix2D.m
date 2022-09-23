function R = RobinMassMatrix2D(p,e,kappa)
    np = size(p,2); % number of nodes
    ne = size(e,2); % number of edges in the mesh
    R = sparse(np,np); % allocate boundary matrix
    
    for i = 1:ne
        loc2glb = e(1:2,i); % i-th triangle edges 
        x = p(1,loc2glb); % x-coordinates of the nodes of the triangle 
        y = p(2,loc2glb); % y-coordinates of the nodes of the triangle
        len = sqrt((x(1)-x(2))^2+(y(1)-y(2))^2); % edge length
        xc = mean(x); 
        yc = mean(y); % edge mid-point
        k = kappa(xc,yc); % value of kappa at mid-point
        Ri = k/6*[2 1; 1 2]*len; % edge boundary matrix
        R(loc2glb,loc2glb) = R(loc2glb,loc2glb) + Ri;
    end
    
end