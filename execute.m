close all
clear all
clc

[FileName,PathName] = uigetfile('*.gpx','Select the path file');

filename=fullfile(PathName,FileName);
trk = gpxread(filename, 'FeatureType', 'track');

trk = heading(trk);
trk = computeDistance(trk);
trk = incline(trk);

issues= find(trk.Distance<1);
trk(issues)=[];

trk = heading(trk);
trk = computeDistance(trk);
trk = incline(trk);

webmap
wmline(trk)

figure
subplot(3,1,1)
plot(trk.DistanceCumulative,trk.Elevation);
subplot(3,1,2)
plot(trk.DistanceCumulative,trk.Incline);
subplot(3,1,3)
plot(trk.DistanceCumulative,asind(trk.Incline));

load('SpeedPD.mat')
speed=abs(random(pd1,[1,length(trk)]));

time = trk.Distance./speed;

W=prampero(67+12,speed, 760.56,282,0.63,(11/3.6),trk.Incline,trk.Heading,0);
Wpos = W;
Wpos(Wpos<0)=0;
E=W.*time;
Epos=E;
Epos(Epos<0)=0;
TotalEnergy=sum(Epos);
TotalTime=sum(time);
SpeedAverage=mean(speed);
PowerAverage=mean(Wpos);
TotalDistance=sum(trk.Distance);

figure
subplot(3,1,1)
geoshow(trk.Latitude,trk.Longitude)
subplot(3,1,2)
plot(trk.DistanceCumulative,W)
hold on
plot(trk.DistanceCumulative,Wpos)
hold off
subplot(3,1,3)
plot(trk.DistanceCumulative,E)
hold on
plot(trk.DistanceCumulative,Epos)
hold off