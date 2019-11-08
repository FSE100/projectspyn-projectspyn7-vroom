move = true;
brick.SetColorMode(1,2);
initialDist = brick.UltrasonicDist(1);

while move
	crash = brick.TouchPressed(3) == 1 || brick.TouchPressed(4) == 1;
	color = brick.ColorCode(2);
	distance = brick.UltrasonicDist(1);

	if color == 3;
		brick.StopAllMotors(‘Brake’);
		break;
	end

	if crash == 1
	%turn right
		brick.StopAllMotors(‘Brake’);
		brick.MoveMotor(‘B’,-50);
		brick.MoveMotor(‘D’,-50);
		pause(0.5);
		brick.StopAllMotors(‘Brake’);
		brick.MoveMotorAngleRel(‘D’,1000,-270,’Brake’);
		brick.MoveMotorAngleRel(‘B’,1000,270,’Brake’);
        	brick.WaitForMotor('B');
        	brick.WaitForMotor('D');
		brick.StopAllMotors(‘Brake’);
        	initialDist = brick.UltrasonicDist(1);
	elseif distance>30
		brick.StopAllMotors(‘Brake’);
		%check if gap in wall or end of wall
		brick.MoveMotorAngleRel(‘D’,1000,100,’Brake’);%adjust values
		brick.MoveMotorAngleRel(‘B’,1000,100,’Brake’);
        	brick.WaitForMotor('B');
        	brick.WaitForMotor('D');
		if distance>30
			%end of wall, turn left
			brick.MoveMotorAngleRel(‘D’,1000,500,’Brake’);%adjust values
			brick.MoveMotorAngleRel(‘B’,1000,100,’Brake’);
            		brick.WaitForMotor('B');
            		brick.WaitForMotor('D');
			break;

	elseif distance<initialDist-10
		brick.StopAllMotors(‘Brake’);
		%turn right a little
		brick.MoveMotorAngleRel(‘B’,1000,80,’Brake’);%adjust adjust value
        	brick.WaitForMotor('B');
		brick.MoveMotor(‘B’,100);
		brick.MoveMotor(‘D’,100);
		pause(0.5);
	elseif distance>initialDist+10
		brick.StopAllMotors(‘Brake’);
		%turn left a little
		brick.MoveMotorAngleRel(‘D’,1000,80,’Brake’);%adjust value
        	brick.WaitForMotor('D');
		brick.MoveMotor(‘B’,100);
		brick.MoveMotor(‘D’,100);
		pause(0.5);
	else
		brick.MoveMotor(‘B’,100);
		brick.MoveMotor(‘D’,100);
		
