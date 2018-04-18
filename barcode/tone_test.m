
% playTone(brick,412.0,0.5,10)

for i = 1:5
    for freq = 2500:-50:350
        %fprintf('freq: %d\n',freq);
        % playTone(brick, freq, dur, vol)
        playTone(brick,freq,0.015,10.0)
        pause(0.015);
    end
    for freq = 350:50:2500
        %fprintf('freq: %d\n',freq);
        % playTone(brick, freq, dur, vol)
        playTone(brick,freq,0.015,10.0)
        pause(0.015);
    end
end
