function mon=doy2mon(doy)

cdaz=[31,59,90,120,151,181,212,243,273,304,334,365];
mon=1;
while(doy>cdaz(mon))
    mon=mon+1;
end

end