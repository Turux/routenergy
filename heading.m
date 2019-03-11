function [trk,heading] = heading(trk)
%HEADING Summary of this function goes here
%   Detailed explanation goes here
dLat = diff(trk.Latitude);
dLon = diff(trk.Longitude);
heading=mod(atan2d(dLat,dLon),360);
trk.Heading=heading;

end

