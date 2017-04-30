% 2D lat/lon plot of Earth's magnetic field strength at given altitude.
% 

clear all;

% array of latitudes and longitudes of satellite
lats = -60:2:60;
lons = -180:2:180;

% altitude of satellite
sat_alt = 750;
mir_alt = 110;
tracestepsize = 10;
Re = 6370;

% load IGRF coefficients
date = datenum(2014,12,31,0,0,0);     % can be a datenum or datevec
global gh;
gh = loadigrfcoefs(date);
  

Bsat = zeros(length(lats),length(lons));
Bdir = zeros(length(lats),length(lons),3);
Bmir = zeros(length(lats),length(lons));

for i = 1:length(lats),
    fprintf('Doing Lat %d of %d\n',i,length(lats));
    for j = 1:length(lons),
        
%       [Bs,Bm,~] = lossconeangle4(gh,lats(i),lons(j),sat_alt,mir_alt,tracestepsize);
        [Bs,Bm] = lossconeangle3(gh,lats(i),lons(j),sat_alt,mir_alt,tracestepsize);
        Bmir(i,j) = norm(Bm);
        
        Bsat(i,j) = norm(Bs);
        Bdir(i,j,:) = Bs(:);
    end
end

lca = real(asind(sqrt(Bsat./Bmir)));

% okay, that's the "correct" field value and direction. How about if we
% move in some direction by some distance? what is the difference in
% pointing direction?

locationerror = 50;     % error in km
direction = 0;          % let's go north for now

Bsat2 = zeros(length(lats),length(lons));
Bmir2 = zeros(length(lats),length(lons));
Bdir2 = zeros(length(lats),length(lons),3);
dirErr = zeros(length(lats),length(lons));

disp('Now doing B-field with location error...');

for i = 1:length(lats),
    fprintf('Doing Lat %d of %d\n',i,length(lats));
    for j = 1:length(lons),
        
        % shift location by locationerror in direction
        [newlat,newlon] = reckon(lats(i),lons(j),locationerror/Re*180/pi,direction);
        
%         [Bs,Bm,~] = lossconeangle4(gh,newlat,newlon,sat_alt,mir_alt,tracestepsize);
        [Bs,Bm] = lossconeangle3(gh,lats(i),lons(j),sat_alt,mir_alt,tracestepsize);

        Bmir2(i,j) = norm(Bm);
        
        Bsat2(i,j) = norm(Bs);
        Bdir2(i,j,:) = Bs(:);
        
        realB = squeeze(Bdir(i,j,:));
        dirErr(i,j) = acosd(dot(realB,Bs)/(norm(realB)*norm(Bs)));
        
    end
end

lca2 = real(asind(sqrt(Bsat2./Bmir2)));

%% PLOTTING


h1 = figure(1);
set(h1,'position',[100 50 1200 900]);
ax1 = subplot(221);
ax2 = subplot(222);
ax3 = subplot(223);
ax4 = subplot(224);

% Background magnetic field

imagesc(lons,lats,Bsat*1e-3,'parent',ax1);
hold(ax1,'on');
title(ax1,sprintf('Magnetic Field intensity at %d km Altitude',...
    sat_alt));

load coast;
plot(ax1,long,lat,'w');
axis(ax1,'xy');
cax1 = colorbar('peer',ax1);
ylabel(cax1,'B-field in thousands of nT');
ylabel(ax1,'Degrees Latitude');

% Percent error in Magnetic Field

imagesc(lons,lats,(Bsat-Bsat2)./Bsat*100,'parent',ax2);
hold(ax2,'on');
title(ax2,sprintf('Magnetic Field %% error at %d km Altitude',...
    sat_alt));

plot(ax2,long,lat,'w');
axis(ax2,'xy');
cax2 = colorbar('peer',ax2);
ylabel(cax2,'% Error');

% Direction error in degrees

imagesc(lons,lats,dirErr,'parent',ax3);
hold(ax3,'on');
title(ax3,'Magnetic Field Direction Error');

plot(ax3,long,lat,'w');
axis(ax3,'xy');
cax3 = colorbar('peer',ax3);
xlabel(ax3,'Degrees Longitude');
ylabel(ax3,'Degrees Latitude');

% Magnetic field after moving 50 km

imagesc(lons,lats,(lca-lca2),'parent',ax4);
hold(ax4,'on');
title(ax4,'Loss Cone Angle Error in degrees');

plot(ax4,long,lat,'w');
axis(ax4,'xy');
cax4 = colorbar('peer',ax4);
caxis(ax4,[-2 2]);
ylabel(cax4,'LCA Error (degrees)');

[lonmat,latmat] = meshgrid(lons,lats);
contour(ax4,lonmat,latmat,(lca-lca2),0.5,'k')
contour(ax4,lonmat,latmat,(lca-lca2),-0.5,'k')

ylabel(cax4,'Degrees');
xlabel(ax4,'Degrees Longitude');

%%

h2 = figure(2);
set(h2,'position',[200 100 800 600]);
ax = axes;

yy = abs(dirErr)+abs(lca-lca2);
imagesc(lons,lats,yy,'parent',ax)
axis(ax,'xy');
hold(ax,'on');
plot(ax,long,lat,'w')
cax = colorbar('peer',ax);
set(ax,'clim',[0 1.5]);

contour(lonmat,latmat,yy,1.5,'k')
contour(lonmat,latmat,yy,1.2,'k')

ylabel(cax,'degrees')
set(ax,'FontSize',14)
ylabel(cax,'degrees','fontsize',14)
title(ax,'Total Error (B error + LCA error)','fontsize',14)
xlabel(ax,'Longitude','fontsize',14)
ylabel(ax,'Latitude','fontsize',14);

