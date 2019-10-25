timerVal = 0

while brick.TouchPressed(1) == 0
    
end

tic;

while brick.TouchPressed(1) == 1
    
end

timerVal = toc


brick.playTone(1000, timerVal, timerVal * 100);
pause(0.75)
brick.playTone(1000, timerVal, timerVal * 100);
pause(0.75)
brick.playTone(1000, timerVal, timerVal * 100);