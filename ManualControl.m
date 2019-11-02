global key
InitKeyboard();

while 1
    pause(0.1);
    switch key
        case 'uparrow'
            disp('Up Arrow Pressed!');
            brick.MoveMotor('A', 100);
            brick.MoveMotor('D', 100);
            
        case 'downarrow'
            disp('Down Arrow Pressed!');
            brick.MoveMotor('A', -50);
            brick.MoveMotor('D', -50);
            
        case 'leftarrow'
            disp('Left Arrow Pressed!');
            brick.MoveMotor('D', 50);
        
        case 'rightarrow'
            disp('Right Arrow Pressed!');
            brick.MoveMotor('A', 50);
            
        case '1'
            disp('Motor Raised!');
            brick.MoveMotorAngleRel('C', 5, -45, 'Brake');
            pause(0.5);
        
        case '2'
            disp('Motor Lowered!');
            brick.MoveMotorAngleRel('C', 5, 25, 'Brake');
            pause(0.5);
            
        case 0
            disp('No Key Pressed');
            brick.StopAllMotors('Brake');
        
        case 'q'
            break;
    end
end

CloseKeyboard();