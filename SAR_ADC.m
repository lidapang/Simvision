% visualize functionality of ideal adc
close all;

in = -0.2
vref = 2;
vdd = 3.3;

digital_val = zeros(1,12);
analog_val = zeros(1,12);
in_list = zeros(1,13);
in_list(1) = in;

% determin sign
if in_list(1) <= 0
   digital_val(1) = 1;
   analog_val(1) = vdd;
   in_list(2) = 2*(in_list(1)+0.25*vref);
else
   in_list(2) = 2*(in_list(1)-0.25*vref);
end

for i=[2:12]
    if in_list(i) > 0
      digital_val(i) = 1;
      analog_val(i) = vdd;
      in_list(i+1) = 2*(in_list(i)-0.25*vref);
    else
      in_list(i+1) = 2*(in_list(i)+0.25*vref);
    end
end

% reconstruct
reconstruct = digital_val;

reconstruct(1) = reconstruct(1)*(-1)*(2^(11));
for i=[2:12]
    reconstruct(i) = reconstruct(i)*(2^(12-i));
end

val = sum(reconstruct)/(2^11)

figure(1)
stairs(in_list)
hold on
stairs(digital_val)