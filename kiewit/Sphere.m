function z = Sphere(x)
    weight=[11.261 14.223 16.89 20.513 24.143 27.929 31.069 33.07 36.524 38.105 42.03	43.492 47.888	52.717	57.741	62.765	60.037	65.689	71.341	67.598	73.878	80.158	80.42 87.485 94.55 93.654 101.504 109.354 106.316 115.108 123.9 121.407 131.298 141.189];
    H=0.25*x(1)+4.75;
    m=5;         %»·Êý
    n=x(2)+2;    %¶ÎÊý
    span=80;
    R=span/2;
    r=R/m;
    arc=(R^2+H^2)/(2*H);
    
    NODES=[0 0 H 0 0 0 0 0 0 0 0 0];
    for i=1:m
        N=zeros(n*i,12);
        for j=1:n*i
            N(j,1)=r*i*cos(2*pi*(j-1)/(n*i));
            N(j,2)=r*i*sin(2*pi*(j-1)/(n*i));
            N(j,3)=sqrt(arc^2-(r*i)^2)-arc+H;
        end
        NODES=[NODES;N];
    end
    %topo
    NP=[];
    g=0;
    for i=1:m-1
        start_node=i*(i-1)*n/2+2;
        end_node=start_node+i*n-1;
        for j=start_node:end_node-1
            NP=[NP;j j+1];
        end
        NP=[NP;start_node end_node];
        g=[g,length(NP(:,1))];
    end
    %g1=length(NP(:,1));


    COL=[];
    for i=2:n+1
        col=ones(1,m+1);
        col(1)=1;
        col(2)=i;
        for j=3:m+1
            col(j)=col(j-1)+n*(j-2)+i-2;
        end
        COL=[COL;col];
        for k=1:length(col)-1
            NP=[NP;col(k),col(k+1)];
        end
    end
    g=[g,length(NP(:,1))];
    %g2=length(NP(:,1));

    COL=reshape(COL,1,[]);
    for i=1:m-1
        start_node_1=i*(i-1)*n/2+2;
        end_node_1=start_node_1+i*n-1;
        line_1=[start_node_1:end_node_1];
        start_node_2=i*(i+1)*n/2+2;
        end_node_2=start_node_2+(i+1)*n-1;
        line_2=[start_node_2:end_node_2];
        line_2=setdiff(line_2,COL);
        con=[];
        for j=1:n*i
            con=[con line_1(j) line_2(j)];
        end
        for k=1:length(con)-1
            NP=[NP;con(k) con(k+1)];
        end
        NP=[NP;con(end) con(1)];
        g=[g,length(NP(:,1))];
    end
    %g3=length(NP(:,1));
    
%     l1=0;
%     l2=0;
%     l3=0;
    
l=[];
for i=1:9
    lp=0;
    for j=g(i)+1:g(i+1)
        n1=NP(j,1);
        n2=NP(j,2);
        x1=NODES(n1,1);
        y1=NODES(n1,2);
        z1=NODES(n1,3);
        x2=NODES(n2,1);
        y2=NODES(n2,2);
        z2=NODES(n2,3);
        lp=lp+sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2);
    end
    l=[l,lp];
end

    a=l.*weight(x(3:11));
    z=sum(a);
end
