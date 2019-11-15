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