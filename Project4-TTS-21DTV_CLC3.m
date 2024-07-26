clear all;
close all;
%Ma trận kiểm tra
H=[1 1 0 1 0 0
    0 1 1 0 1 0
    1 0 0 0 1 1
    0 0 1 1 0 1];
%Từ mã truyền
c=[0 0 1 0 1 1];
% Từ mã nhận
r=[1 0 1 0 1 1];
y=r;
%Số lần lặp
maxiter=20;
%Đánh dấu giải mã chưa thành công
success = 0;
while iter<maxiter && ~success % Điều kiện vòng lặp
    %Khởi tạo ma trận lỗi
    E=zeros(4,6);
    for j = 1:4
        for i = 1:6
            if (H(j,i)==1)
                %Xác định ma trận lỗi
                E(j,i) = y(i)*H(j,i);
            end
        end
    end
    for j = 1:4
        if mod(sum(E(j,:)),2)
                 for i = 1:6
                     if (H(j,i)==1)
                         E(j,i) = 1;
                     end
                 end
         else
            E(j,:) = [0 0 0 0 0 0];
        end
    end

    % Tìm vị trí có nhiều lỗi nhất
    for i=1:6
        M(i)=sum(E(:,i));
    end
    [M,index] = max(M);


    % Sửa lỗi
    if M~=0
        y(index) = ~y(index);
    end
    % Kiểm tra sau khi đảo bit
    areErrorsPresent = check_errors(H, y);
    if areErrorsPresent == 0 % Không lỗi
        success = 1;
        disp("No error");
    else %Có lỗi
        disp("Still errors");
    end
    iter=iter+1;
end
% Hàm kiểm tra lỗi
function res = check_errors(H, current_frame)
syndrome = H * transpose(current_frame);
areErrors = any(mod(syndrome,2));
res = areErrors;
end