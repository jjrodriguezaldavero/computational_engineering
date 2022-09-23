function r = RobinLoadVector2D(p,e,kappa,gD,gN)

    np = size(p,2); %Number of nodes
    ne = size(e,2); %Number of edges in mesh
    r = zeros(np,1); %Allocate vector

    for i = 1:ne

        loc2glb = e(1:2,i); %i-th local edge
        x = p(1,loc2glb); %x-th coordinate of triangle nodes
        y = p(2,loc2glb); %y-th coordinate of triangle nodes
        len = sqrt((x(1)-x(2))^2+(y(1)-y(2))^2); %length of edge

        xc = mean(x); %triangle x centroid
        yc = mean(y); %triangle y centroid

        tmp = kappa(xc,yc)*gD(xc,yc)+gN(xc,yc);
        ri = tmp*[1; 1]*len/2;

        r(loc2glb) = r(loc2glb) + ri;

    end

end