
function [p,e,t] = CircularMesh(showplot)
    
    global SmallRadius;
    global LargeRadius;
    global Scale;
    global NR;
    global NT;

    theta = 360;
    nsel = NR*(NT-1) ; % Total Number of Elements in the Mesh
    nel = nsel * 2;
    nnel = 3 ; % Number of nodes per Element
    
    % Number of points on the Radius and Angular discretization
    npR = NR+1 ;
    npT = NT ;

    % Mesh scaling function
    scale = ChooseScale(Scale);
    
    % Discretize the Length and Breadth of the plate
    nR = linspace(SmallRadius,LargeRadius,npR);
    nR = scale(nR);
    nT = linspace(0,theta,npT)*pi/180 ;
    [R, T] = meshgrid(nR,nT) ;
    
    % Convert grid to cartesian coordintes
    XX = R.*cos(T); 
    YY = R.*sin(T);

    % Get the coordinates and node matrices
    coordinates = [XX(:) YY(:)] ;

    if nR(1)==0
        nnode = npR*npT-(NT-1) ; % Total Number of Nodes in the Mesh
        NodeNo = [ones(1,NT-1),1:nnode] ;
        coordinates = coordinates(NT:end,:) ;
    else
        nnode = npR*npT ; % Total Number of Nodes in the Mesh
        NodeNo = 1:nnode ;
    end
    
    nodes = zeros(nel,nnel);
    T1 = zeros(nsel, nnel);
    T2 = zeros(nsel, nnel);

    % If elements along the X-axes and Y-axes are equal
    if npR==npT
        
        NodeNo = reshape(NodeNo,npT,npR);
        T1(:,1) = reshape(NodeNo(1:npR-1,1:npT-1),nsel,1);
        T1(:,2) = reshape(NodeNo(2:npR,1:npT-1),nsel,1);
        T1(:,3) = reshape(NodeNo(1:npR-1,2:npT),nsel,1);
        T2(:,1) = reshape(NodeNo(2:npR,1:npT-1),nsel,1);
        T2(:,2) = reshape(NodeNo(2:npR,2:npT),nsel,1);
        T2(:,3) = reshape(NodeNo(1:npR-1,2:npT),nsel,1);
        nodes(1:2:end,:) = T1;
        nodes(2:2:end,:) = T2;

    % If the elements along the axes are different
    else
        
        NodeNo = reshape(NodeNo,npT,npR);
        T1(:,1) = reshape(NodeNo(1:npT-1,1:npR-1),nsel,1);
        T1(:,2) = reshape(NodeNo(2:npT,1:npR-1),nsel,1);
        T1(:,3) = reshape(NodeNo(1:npT-1,2:npR),nsel,1);
        T2(:,1) = reshape(NodeNo(2:npT,1:npR-1),nsel,1);
        T2(:,2) = reshape(NodeNo(2:npT,2:npR),nsel,1);
        T2(:,3) = reshape(NodeNo(1:npT-1,2:npR),nsel,1);
        nodes(1:2:end,:) = T1;
        nodes(2:2:end,:) = T2;

    end

    % PLOTTING
    
    if isequal(showplot, 'true')
        
        % Initialization of the required matrices
        X = zeros(nnel,nel) ;
        Y = zeros(nnel,nel) ;
        % Extract X,Y coordinates for the (iel)-th element
          for iel = 1:nel
              X(:,iel) = coordinates(nodes(iel,:),1) ; 
              Y(:,iel) = coordinates(nodes(iel,:),2) ;
          end

        % Figure
        fh = figure ;
        set(fh,'name','Preprocessing for FEA','numbertitle','off','color','w') ;
        patch(X,Y,'w')
        title('Finite Element Mesh of Circular Plate') ;
        axis off ;
        axis equal ;
    end
    
    %Prepare the output objects p, e, t
    p = coordinates.';
    x = p(1,:);
    y = p(2,:);
    [element2edges, edge2nodes] = getEdges(nodes);
    e = edge2nodes.';
    nodes(:,4) = 1;
    t = nodes.';

    %Show a scatterplot of the mesh with nodes numbered
    % figure(1)
    % scatter(x,y)
    % figure(2)
    % axis([min(x)-1, max(x)+1, min(y)-1, max(y)+1])
    % for k=1:length(x)
    %     text(x(k),y(k),num2str(k))
    % end

    end