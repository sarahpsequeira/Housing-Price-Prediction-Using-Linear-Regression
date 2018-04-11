housing_data=dlmread('housing_price_data.dat');
housing_data_price_size=housing_data(:,[5 2]);
sorted_housing_data_price_size=sortrows(housing_data_price_size);
Size_Of_House_Vector=sorted_housing_data_price_size(25:600,1);
Price_Of_House_Vector=sorted_housing_data_price_size(25:600,2);
figure;
scatter(Size_Of_House_Vector,Price_Of_House_Vector);
title('Scatter plot of housing prices');
xlabel('Size in square Feet');
ylabel('Price');
Max_Size = max(Size_Of_House_Vector);
 Min_Size = min(Size_Of_House_Vector);
Value=Max_Size-Min_Size;
Normailzed_Size_Of_House=Size_Of_House_Vector./Value;
w0=0;
w1=0;
learning_rate=0.1;
i=1;
cost=0;
error=zeros(1,1);
while true
    temp0=w0-(learning_rate*(1/576)*(sum(w0+w1*Normailzed_Size_Of_House-Price_Of_House_Vector)));
    temp1=w1-(learning_rate*(1/576)*(sum((w0+w1*Normailzed_Size_Of_House-Price_Of_House_Vector).*Normailzed_Size_Of_House)));
    
    w0=temp0;
    w1=temp1;
    
    f=w0 + w1*Normailzed_Size_Of_House;
    cost=(1/(2*576))*(sum((f-Price_Of_House_Vector).^2));
    error(i)=cost;
    
    if(i~=1 && (error(i-1)-error(i))<0.5)
      break;
    end
    
    i=i+1;
    error=[error;zeros(1,1)];
end

figure;
hold off;
scatter(Size_Of_House_Vector,Price_Of_House_Vector,5);
hold;
plot(Size_Of_House_Vector,f,'r');
xlabel('Size in square Feet'); 
ylabel('Price');
figure; 
plot(error);
xlabel('Iterations');
ylabel('Error');
fprintf('Algorithm converges after %d iterations, learning rate=%5.3f \n', i, learning_rate);
