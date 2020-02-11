function DispProt(coords,vals)
    pairs = findPairs(coords, vals);
    figure
    %set the upper and lower bounds of the axes (can be manually changed)
    xlim([-6,6]);
    ylim([-6,max(coords{1}(2)+1, coords{end}(2)+1)]);
    zlim([-6,6]);
    hold on
    view(3)
    for i=1:length(coords)

        % plots a circle based on if its an H or a P
        if vals(i) == 1
            %circle(coords{i}(1),coords{i}(2),0.2,1);
            [x,y,z] = sphere;
            holymotherofgoditsaspherewhatdowedonow = surf(x*0.2+coords{i}(1),y*0.2+coords{i}(2),z*0.2);
            set(holymotherofgoditsaspherewhatdowedonow, 'FaceColor',[1 0 0], 'edgecolor', 'none')
        elseif vals(i) == 0
            %circle(coords{i}(1),coords{i}(2),0.2,0);
            [x,y,z] = sphere;
            holymotherofgoditsaspherewhatdowedonow = surf(x*0.2+coords{i}(1),y*0.2+coords{i}(2),z*0.2);
            set(holymotherofgoditsaspherewhatdowedonow, 'FaceColor',[0 0 1], 'edgecolor', 'none')
        end

        %connects circles with a black line
        if i ~= 1
            plot([coords{i-1}(1),coords{i}(1)],[coords{i-1}(2), coords{i}(2)],'Color','black','LineWidth',5);
        end
        pause(0.1)
    end
    numPairs = 0;
    if(length(pairs) > 0)
        for k = 1:2:length(pairs)
            hold on
            plot([pairs{k}(1),pairs{k+1}(1)],[pairs{k}(2),pairs{k+1}(2)],'Color','green','LineWidth',5);
            %plot([-1,12],[0,12],'Color','green','LineWidth',5);
            numPairs = numPairs + 1;
            pause(0.1)
        end
    end
end

