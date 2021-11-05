clear all; 
close all; 
clc;

%% A - Señal de información 
%bits = mod( reshape(randperm(1*30), 1,30), 2); %50% de probabilidad 1 - 0
rango = [0,1]; %Generanmos 0 y 1 con probabilidad variable
size = [1,30]; % Tamaño de matriz 
bits = randi(rango,size);
%bits = randi(rango,size, 2);

%Definimos el nivel de voltaje para graficar
bits2=bits;
bits2(bits2>0) = 1.7; 
bits2(bits2==0) = 0.6; 
figure(1);
t=1:30;
stem(t,bits2,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
title('Señal de Información')
xlabel('Bits')
ylabel('Voltaje')
grid on;


%% B - Señal Código 
Codigo = [1,0,0,1,1];
%Definimos el nivel de voltaje para graficar
codigo = Codigo;
codigo(codigo>0) = 1.7; 
codigo(codigo==0) = 0.6; 
%disp(codigo);
figure(2);
t2=1:5;
stem(t2,codigo,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
title('Señal Código')
xlabel('Bits')
ylabel('Voltaje')
grid on;

%% XOR Señal de Información y Señal Código 
dsss = [];
contador = 1; 
for A = codigo
  for B = bits 
        dsss(contador) = xor(A,B);
        contador = contador + 1;
  end 
end
%Definimos el nivel de voltaje para graficar
DSSS1 = dsss;
DSSS1(DSSS1>0) = 1.7; 
DSSS1(DSSS1==0) = 0.6; 
%disp(DSSS);
figure(3);
t3=1:150;
stem(t3,DSSS1,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
title('Señal de información XOR Señal Código ')
xlabel('Bits')
ylabel('Voltaje')
grid on;


%% Se adiciona en la trama ruido 
P=reshape(DSSS1,[30,5]);
% v = DSSS;
% v_split = mat2cell(v, 1, 5*ones(150/5),1);  
trama1 = P(:,1,end);
trama2 = P(:,2,end);
trama3 = P(:,3,end);
trama4 = P(:,4,end);
trama5 = P(:,5,end);

dato1 = [];
for F = trama1
     dato1 = F+1.8;
end
% disp(dato1);

dato2 = [];
for G = trama2
     dato2 = G-0.7;
end

% disp(dato2);
dato3 = [];
for H = trama3
     dato3 = H+0.8;
end

%disp(dato3);
dato4 = [];
for I = trama4
     dato4 = I-1.5;
end
%disp(dato4);

dato5 = [];
for J = trama5
     dato5 = J+0.3;
end
%     disp(dato5);
    noise1 = reshape(dato1,1,[]);
    noise2 = reshape(dato2,1,[]);
    noise3 = reshape(dato3,1,[]);
    noise4 = reshape(dato4,1,[]);
    noise5 = reshape(dato5,1,[]);
    noisetotal = [noise1 noise2 noise3 noise4 noise5];
%   disp(noisetotal); 
    
figure(4);
t4=1:150;
stem(t4,noisetotal,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
title('Señal de ruido + Señal DSSS ')
xlabel('Bits')
ylabel('Voltaje')
grid on;


%% HARD-DECISION
signal_ruido = noisetotal;
signal_ruido(signal_ruido>=1) = 1; 
signal_ruido(signal_ruido<1) = 0; 
%disp(signal_ruido);
figure(5);
t5=1:150;
stem(t5,signal_ruido,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
title('Hard D ')
xlabel('Bits')
ylabel('Voltaje')
grid on;


%% RECEPTOR
rxx = signal_ruido;
rxx(rxx>=1) = 1.7; 
rxx(rxx<1) = 0.6; 
%disp(signal_ruido);
figure(6);
t6=1:150;
stem(t6,rxx,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
title('Receptor ')
xlabel('Bits')
ylabel('Voltaje')
grid on;

%% Tasa de error 
P1=reshape(signal_ruido,[30,5]); 
tramae1 = P1(:,1,end);
tramae2 = P1(:,2,end);
tramae3 = P1(:,3,end);
tramae4 = P1(:,4,end);
tramae5 = P1(:,5,end);
tasa = ones(1,5);
rx = [];

for i = 1:30
   tasa(:, :, i)  =  xor(P1(i,:),codigo);
   rx = numel(find(tasa==1))/30;
   tasatotal = rx/5;
   
end
db = ['La tasa total de error es ',num2str(tasatotal)];
disp(db); 

%% Velocidad de Transmision y BW
% 1/0.25us = 4 000 000 = 4Mbps 
% bw = 4Mbps * 2 = 8Mbps
% 
% 1/0.05us = 20 000 000 = 20Mbps
% bw = 20Mbps * 2 = 40Mbps
 
