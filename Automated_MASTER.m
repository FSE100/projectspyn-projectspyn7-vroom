%Port B = Left Motor
%Port D = Right Motor
%Port 1 = Ultrasonic Sensor
%Port 2 = Color Sensor
%Port 3 = Left Crash Sensor
%Port 4 = Right Crash Sensor

if brick == null
	connectToEV3;
end

brick.SetColorMode(2, 2);  % Set Color Sensor connected to Port 2 to Color Code Mode

pickupColor = colorAssigner(lower(input("Enter pickup color: ")));
dropOffColor = colorAssigner(lower(input("Enter drop-off color: ")));

goToDestination(pickupColor);
manualControl();
goToDestination(dropOffColor);
manualControl();

function goToDestination(pickupColor)
	move = true;
	
	while move
		crash = brick.TouchPressed(3) == 1 || brick.TouchPressed(4) == 1;
		%display(crash);
		color = brick.ColorCode(2);
		distance = brick.UltrasonicDist(1);
		
		if color == pickupColor
			%At pickup or drop-off color completely stop the car and break the loop
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
end

function manualControl
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
				disp('Down Arrow Pressed!');
				brick.MoveMotor('B', -25);
				brick.MoveMotor('D', -25);

			case 'leftarrow'
				disp('Left Arrow Pressed!');
				brick.MoveMotor('D', 25);

			case 'rightarrow'
				disp('Right Arrow Pressed!');
				brick.MoveMotor('B', 25);

			case '1'
				disp('Motor Raised!');
				brick.MoveMotorAngleRel('C', 2, -50, 'Coast');
				pause(1.5);

			case '2'
				disp('Motor Lowered!');
				brick.MoveMotorAngleRel('C', 2, 50, 'Coast');
				pause(1.5);

			case 0
				disp('No Key Pressed');
				brick.StopAllMotors('Brake');

			case 'q'
				break;
		end
	end

	CloseKeyboard();
end

function color = colorAssigner(inputColor)
	if inputColor == 'black'
		color = 1
	elseif inputColor == 'blue'
		color = 2
	elseif inputColor == 'green'
		color = 3
	elseif inputColor == 'yellow'
		color = 4
	elseif inputColor == 'red'
		color = 5
	elseif inputColor == 'white'
		color = 6
	else
		color = 0
	end
end

function connectToEV3
	brick = ConnectBrick('BEANS');
	brick.playTone(50, 800, 500);
	brick.GetBattVoltage();
end