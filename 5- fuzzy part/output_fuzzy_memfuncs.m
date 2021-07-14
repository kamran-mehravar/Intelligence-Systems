t=0:0.1:100;
yy1 = trimf(t,[0,0,50]);
yy2 = trimf(t,[33 50 67]);
yy3 = trimf(t,[50,100,100]);
figure;plot(t,yy1,'LineWidth',2); hold on
plot(t,yy2,'r','LineWidth',2); 
plot(t,yy3,'c','LineWidth',2);
plot(t,yy1,t,yy2,t,yy3)

