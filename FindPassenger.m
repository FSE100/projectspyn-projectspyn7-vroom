move = true;
brick.SetColorMode(1, 2);  % Set Color Sensor connected to Port 1 to Color Code Mode

while move
    crash = brick.TouchPressed(3) == 1 || brick.TouchPressed(4) == 1;
    %display(crash);
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(1);
    
    if color == 3
        brick.StopAllMotors('Brake');
        break;
    end
    
    if crash == 1
        %turn right
        brick.StopAllMotors('Brake');
        brick.MoveMotor('B', -50);
        brick.MoveMotor('D', -50);
        pause(0.5);
        brick.StopAllMotors('Brake');
        brick.MoveMotorAngleRel('D', 1000, -270, 'Brake');
        brick.MoveMotorAngleRel('B', 1000, 270, 'Brake');
        pause(0.5);
        brick.StopAllMotors('Brake');
    elseif distance < 10
        %veer right
        display("this goes right");
        brick.MoveMotor('B', 60);
        brick.MoveMotor('D', 50);
    else
        %veer left
        display("this goes left");
        brick.MoveMotor('B', 50);
        brick.MoveMotor('D', 55);
    end
    
end

