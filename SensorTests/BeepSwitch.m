display('Push the button to strt the tone')

while true
    x = brick.TouchPressed(1)
    if x == 1
        brick.playTone(100, 300, 500);
        display('Release button to turn tone OFF')
    end
end
    