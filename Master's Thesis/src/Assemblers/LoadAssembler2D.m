function b = LoadAssembler2D(p,t,f)
    
    global distrib;

    np = size(p,2); %Number of nodes
    nt = size(t,2); %Number of elements
    b = zeros(np,1); %Allocate load vector

    for i = 1:nt
        
        loc2glb = t(1:3,i); %Select i-th triangle
        x = p(1,loc2glb); %x-coordinates of element nodes
        y = p(2,loc2glb); %y-coordinates of element nodes
        area = polyarea(x,y); %Triangle area
        
        bi = [f(x(1),y(1), distrib); f(x(2),y(2), distrib); f(x(3),y(3), distrib)]/3*area; % i-th triangle load vector
        b(loc2glb) = b(loc2glb) + bi; % add i-th triangle load to b
    end
    
end