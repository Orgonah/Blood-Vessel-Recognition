function [sensitivity,specificity,accuracy] = evaluator(predict_image,main_image)
    
    % comute how many 1's is in the temp
    temp = bitand(predict_image,main_image);
    TP = double(sum(temp(:)));
    temp = bitand(~predict_image,~main_image);
    TN = double(sum(temp(:)));
    temp = bitand(predict_image,~main_image);
    FP = double(sum(temp(:)));
    temp = bitand(~predict_image,main_image);
    FN = double(sum(temp(:)));
    sensitivity = TP/(TP+FN);
    specificity = TN/(TN+FP);
    accuracy = (TP + TN)/(TP + TN + FP + FN);
    
end

