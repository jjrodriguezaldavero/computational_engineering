function A = StiffnessAssembler2D(p,t,a)

    np = size(p,2); %number of nodes
    nt = size(t,2); %number of elements (triangles)
    A = sparse(np,np); % allocate stiffness matrix
    
    for i = 1:nt
        loc2glb = t(1:3,i); % local-to-global map (i-th element of the mesh)
        x = p(1,loc2glb); % x-coordinates of the nodes of the element
        y = p(2,loc2glb); % y-coordinates of nodes of the element
        
        [area,b,c] = HatGradients(x,y); % Coefficients of the i-th hat function
        
        xc = mean(x); % x-coordinate centroid
        yc = mean(y); % y-coordinate centroid
        
        abar = a(xc,yc); % value of a(x,y) at centroid
        
        Ai = abar*(b*b'+c*c')*area; % i-th element of stiffness matrix
        A(loc2glb,loc2glb) = A(loc2glb,loc2glb)+ Ai; % add element stiffnesses to A
    end
    
end