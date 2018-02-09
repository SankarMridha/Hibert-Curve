clc;
clear all;

%% Initially Parameters 

% INPUT parameter (We can change the recursion value for getting different shape)
Recursion = 4;

% Other parameter
Grid_length = 4^(Recursion + 1);                                             % Maximum grid length
Grid_point = 2^Recursion + 1;                                                % Number of Grid points
Point = Grid_length;                                                         % Number of points
Max_x_co = Grid_length;                                                      % Maximum value of x coordinate
Max_y_co = Grid_length;                                                      % Maximum value of y coordinate
Small_block_step = Grid_length / sqrt(Point);                                % Each block size
Point_x = 0;                                                                 % Initial Point for x coordinate
Point_y = 0;                                                                 % Initial Point for y coordinate

%% Prepare DataSet (Calculate all data points)
k = 1;
for i = Small_block_step : 2*Small_block_step : Max_x_co
    for j = Small_block_step : 2*Small_block_step : Max_y_co
    All_Point(1,k) = j;
    All_Point(2,k) = i;
    All_Point(3,k) = k;
    k = k + 1;
    end
end
 All_Point
 Initial_Co = 4^Recursion                                                     % Select the begining point of draw line
 
 % place the point into plot
 [row col] = size(All_Point);
 for i = 1 : col
     plot(All_Point(1,i),All_Point(2,i),'r');
     %plot(All_Point(1,i),All_Point(2,i),'.r');                               % Alternate code
     hold on;
     % Select the coordinate of starting point
     if All_Point(3,i) == Initial_Co
         plot(All_Point(1,i),All_Point(2,i),'g');
         %plot(All_Point(1,i),All_Point(2,i),'g');                            % Alternate code
         SourceNode_x = All_Point(1,i);
         SourceNode_y = All_Point(2,i);
         hold on;
     end
 end
 
 %% Draw the plot
 Axiom = 'A';                                                                 % Input String
 A = '-BF+AFA+FB-';                                                           % Production rules
 B = '+AF-BFB-FA+';
 % Prepare the string data set
 if Recursion == 0
     Axiom = '';
 else
    for i = 1 : Recursion                                                     % Number of  recursion 
        Axiom_temp = '';                                                      % Variable store new dataset
        for j = 1 : length(Axiom) 
            if Axiom(j) == 'A'
                Axiom_temp = strcat(Axiom_temp,A);                            % Relace 'L' by  rule L
            elseif Axiom(j) == 'B'
                Axiom_temp = strcat(Axiom_temp,B);                            % Relace 'L' by  rule L
            else
                Axiom_temp = strcat(Axiom_temp,Axiom(j));                      
            end
        end
        Axiom = Axiom_temp;                                                   % New dataset is now the original string
    end
 end
 % Replace all 'L' & 'R' from final string
 Axiom = strrep(Axiom,'A','');
 Axiom = strrep(Axiom,'B','');
 % Final string
 Axiom;
 Axiom_size = length(Axiom);
 % We assuse 4 direction, 1 for Up, 2 for Left, 3 for down, & 4 for right 
 Direction = 4;
 SourceNode_x;
 SourceNode_y;
 for i = 1: Axiom_size                                                          
     if Axiom(i) == '+'                                                       % '-' means 90 degree right so add 1 to change direction
         Direction = Direction + 1;
     elseif Axiom(i) == '-'
         Direction = Direction - 1;                                           % '+' means 90 degree left so minus 1 to change direction
     else
         if Direction > 4                                                     % tune the direction between 1 to 4
             Direction = Direction - 4;
         elseif Direction < 1
             Direction = 4;
         end
         if Direction == 1                                                    % Direction 1 means draw towards Up direction so only y axis update
            SinkNode_x = SourceNode_x; 
            SinkNode_y = SourceNode_y + 2*Small_block_step;
         elseif Direction == 2                                                % Direction 2 means draw towards Left direction so only x axis update
            SinkNode_x = SourceNode_x + 2*Small_block_step;   
            SinkNode_y = SourceNode_y;             
         elseif Direction == 3                                                % Direction 3 means draw towards Down direction so only y axis update
            SinkNode_x = SourceNode_x; 
            SinkNode_y = SourceNode_y - 2*Small_block_step;   
         else
            SinkNode_x = SourceNode_x - 2*Small_block_step;                   % Direction 4 means draw towards right direction so only x axis update
            SinkNode_y = SourceNode_y;
         end
        % Color code for each line
         a(1) = round(rand());
         a(2) = round(rand());
         a(3) = round(rand());
         if (a(1) == 0 && a(2) == 0 && a(3) == 0)
             Index = round(2* rand() + 1);
             a(Index) = 1;
         elseif (a(1) == 1 && a(2) == 1 && a(3) == 1)
             Index = round(2* rand() + 1);
             a(Index) = 0;
         end
         plot([SourceNode_x SinkNode_x], [SourceNode_y SinkNode_y],'Color',[a(1) a(2) a(3)]);
         hold on
         SinkNode_x;
         SinkNode_y;
         % Sink coordinate is now current position 
         SourceNode_x = SinkNode_x;
         SourceNode_y = SinkNode_y;
     end
 end

 