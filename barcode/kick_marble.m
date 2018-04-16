% only responsible for performing a kicking motion
function [] = kick_marble(m, speed)
    m.Speed = abs(speed);
    start(m);
    pause(0.25);
    stop(m);
    pause(1);
    m.Speed = -1 * abs(speed);
    start(m);
    pause(0.25);
    stop(m);
end