%Port B = Left Motor
%Port D = Right Motor
%Port C = Pickup Motor
%Port 1 = Ultrasonic Sensor
%Port 2 = Color Sensor
%Port 3 = Left Crash Sensor
%Port 4 = Right Crash Sensor

brick.SetColorMode(2, 2);  % Set Color Sensor connected to Port 2 to Color Code Mode

goToDestination(3); %Green Pickup
manualControl();
goToDestination(4); %Blue Dropoff
manualControl();

function goToDestination(colorDestination)
    global brick
	move = true;
    
    colorCount = 0;
    
	while move
		crash = brick.TouchPressed(3) == 1 || brick.TouchPressed(4) == 1;
		%display(crash);
		color = brick.ColorCode(2);
        if color == 2
            disp("Blue");
        elseif color == 3
            disp("Green");
        elseif color == 4
            disp("yellow");
        else
            disp(color);
        end
        
        if color ~= colorDestination
            colorCount = 0;
        end
        
        if color == colorDestination
            colorCount = colorCount + 1;
            if colorCount > 4
                brick.StopAllMotors('Brake');
                break;
            end
        elseif color == 5
			%At red pause the car for 4 seconds
			brick.StopAllMotors('Brake');
			pause(4);
            brick.MoveMotor('BD', 50);
            pause(0.5);
		end
            
        %disp(color);
		distance = brick.UltrasonicDist(1);
		
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
		elseif distance < 20.00
			%veer right
			brick.MoveMotor('B', 100);
			brick.MoveMotor('D', 90);
		elseif distance > 25.00
			%veer extreme left
			%display("this goes LOT left");
			brick.MoveMotor('B', 50);
			brick.MoveMotor('D', 70);
		else
			%veer left
			%display("this goes left");
			brick.MoveMotor('B', 90);
			brick.MoveMotor('D', 100);
		end
	end
end

function manualControl
    global brick
	global key
	InitKeyboard();

	while 1
		pause(0.1);
		 switch key
			case 'uparrow'
				disp('Up Arrow Pressed!');
				brick.MoveMotor('B', 25);
				brick.MoveMotor('D', 25);

			case 'downarrow'
				%disp('Down Arrow Pressed!');
				brick.MoveMotor('B', -25);
				brick.MoveMotor('D', -25);

			case 'leftarrow'
				%disp('Left Arrow Pressed!');
				brick.MoveMotor('D', 25);

			case 'rightarrow'
				%disp('Right Arrow Pressed!');
				brick.MoveMotor('B', 25);

			case '1'
				%disp('Motor Raised!');
				brick.MoveMotorAngleRel('C', 2, -50, 'Coast');
				pause(1.5);

			case '2'
				%disp('Motor Lowered!');
				brick.MoveMotorAngleRel('C', 2, 50, 'Coast');
				pause(1.5);

			case 0
				%disp('No Key Pressed');
				brick.StopAllMotors('Brake');

			case 'q'
				break;
		end
	end

	CloseKeyboard();
end