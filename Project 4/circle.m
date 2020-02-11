function h = circle(x,y,r,val)
%hold on
%th = 0:pi/50:2*pi;
%xunit = r * cos(th) + x;
%yunit = r * sin(th) + y;
%h = plot(xunit, yunit);
%hold off
ang=0:0.01:2*pi;
xp=r*cos(ang);
yp=r*sin(ang);

if val == 1
    plot(x+xp,y+yp, 'bl','MarkerSize',100);
    
elseif val == 0
    plot(x+xp,y+yp, 'r','MarkerSize',100);
end
