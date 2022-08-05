load('YET_Y_14_03.mat')
% Time
Y_time_relative_error{1,1} = YTE1;
Y_time_relative_error{1,2} = YTE2;
Y_time_relative_error{1,3} = YTE4;
Y_time_relative_error{1,4} = YTE8;
Y_time_relative_error{1,5} = YTEm;
Y_time_relative_error{1,6} = YTEeb;
Y_time_relative_error{1,7} = YTEfb;

Y_time_absolute_error{1,1} = abs(YTE1);
Y_time_absolute_error{1,2} = abs(YTE2);
Y_time_absolute_error{1,3} = abs(YTE4);
Y_time_absolute_error{1,4} = abs(YTE8);
Y_time_absolute_error{1,5} = abs(YTEm);
Y_time_absolute_error{1,6} = abs(YTEeb);
Y_time_absolute_error{1,7} = abs(YTEfb);

% Freq
Y_freq_relative_error{1,1} = YET1c;
Y_freq_relative_error{1,2} = YET2c;
Y_freq_relative_error{1,3} = YET4c;
Y_freq_relative_error{1,4} = YET8c;
Y_freq_relative_error{1,5} = YETm;
Y_freq_relative_error{1,6} = YETeb;
Y_freq_relative_error{1,7} = YETfb;

Y_freq_absolute_error{1,1} = abs(YET1c);
Y_freq_absolute_error{1,2} = abs(YET2c);
Y_freq_absolute_error{1,3} = abs(YET4c);
Y_freq_absolute_error{1,4} = abs(YET8c);
Y_freq_absolute_error{1,5} = abs(YETm);
Y_freq_absolute_error{1,6} = abs(YETeb);
Y_freq_absolute_error{1,7} = abs(YETfb);


load('YET_O_14_03.mat')
% Time
O_time_relative_error{1,1} = YTE1;
O_time_relative_error{1,2} = YTE2;
O_time_relative_error{1,3} = YTE4;
O_time_relative_error{1,4} = YTE8;
O_time_relative_error{1,5} = YTEm;
O_time_relative_error{1,6} = YTEeb;
O_time_relative_error{1,7} = YTEfb;

O_time_absolute_error{1,1} = abs(YTE1);
O_time_absolute_error{1,2} = abs(YTE2);
O_time_absolute_error{1,3} = abs(YTE4);
O_time_absolute_error{1,4} = abs(YTE8);
O_time_absolute_error{1,5} = abs(YTEm);
O_time_absolute_error{1,6} = abs(YTEeb);
O_time_absolute_error{1,7} = abs(YTEfb);

% Freq
O_freq_relative_error{1,1} = YET1c;
O_freq_relative_error{1,2} = YET2c;
O_freq_relative_error{1,3} = YET4c;
O_freq_relative_error{1,4} = YET8c;
O_freq_relative_error{1,5} = YETm;
O_freq_relative_error{1,6} = YETeb;
O_freq_relative_error{1,7} = YETfb;

O_freq_absolute_error{1,1} = abs(YET1c);
O_freq_absolute_error{1,2} = abs(YET2c);
O_freq_absolute_error{1,3} = abs(YET4c);
O_freq_absolute_error{1,4} = abs(YET8c);
O_freq_absolute_error{1,5} = abs(YETm);
O_freq_absolute_error{1,6} = abs(YETeb);
O_freq_absolute_error{1,7} = abs(YETfb);
