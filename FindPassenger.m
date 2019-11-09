%Port B = Left Motor
%Port D = Right Motor
%Port 1 = Ultrasonic Sensor
%Port 2 = Color Sensor
%Port 3 = Left Crash Sensor
%Port 4 = Right Crash Sensor

brick.StopAllMotors('Brake');

move = true;
brick.SetColorMode(2, 2);  % Set Color Sensor connected to Port 2 to Color Code Mode

while move
    crash = brick.TouchPressed(3) == 1 || brick.TouchPressed(4) == 1;
    %display(crash);
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(1);
    
    if color == 3
        %At green completely stop the car and break the loop
        brick.StopAllMotors('Brake');
        break;
    elseif color == 5
        %At red pause the car for 2 seconds
        brick.StopAllMotors('Brake');
        pause(2);
    end
    
    if crash == 1
        %turn right
        brick.StopAllMotors('Brake');
        brick.MoveMotor('BD', -50);
        %brick.MoveMotor('D', -50);
        pause(0.5);
        brick.StopAllMotors('Brake');
        brick.MoveMotorAngleRel('D', -100, 180, 'Brake');
        brick.MoveMotorAngleRel('B', 100, 180, 'Brake');
        pause(0.5);
        brick.StopAllMotors('Brake');
    elseif distance < 15.00
        %veer right
        brick.MoveMotor('B', 60);
        brick.MoveMotor('D', 50);
    elseif distance > 25.00
        %veer extreme left
        display("this goes LOT left");
        brick.MoveMotor('B', 50);
        brick.MoveMotor('D', 70);
    else
        %veer left
        display("this goes left");
        brick.MoveMotor('B', 50);
        brick.MoveMotor('D', 60);
    end
    
end