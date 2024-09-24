clear; clc; close all

avg_sens = 0;
avg_spec = 0;
avg_accu = 0;
disp(["Num   Sensitivity   Specificity   Accuracy"])
%for i=21:40
for i=1:20
    num = sprintf('%02d', i);
    
    % Training
    % image_address = append("DRIVE\Training\images\",num,"_training.tif");
    % mask_address = append("DRIVE\Training\mask\",num,"_training_mask.gif");
    % manual_address = append("DRIVE\Training\1st_manual\",num,"_manual1.gif");
    
    % Test
    image_address = append("DRIVE\Test\images\",num,"_test.tif");
    mask_address = append("DRIVE\Test\mask\",num,"_test_mask.gif");

    % Test 1
    % manual_address = append("DRIVE\Test\1st_manual\",num,"_manual1.gif");
    
    % Test 2
    manual_address = append("DRIVE\Test\2nd_manual\",num,"_manual2.gif");
    
    % Creates the predicted image of vessels
    predict_image = track_vessel(image_address,mask_address);
    manual_image = double(imread(manual_address));


    % double to logical
    thresh = zeros(size(manual_image)) + 0.5;
    manual_image = manual_image > thresh;
    predict_image = predict_image > thresh;
    
    % Compare it to manual image
    [sensitivity,specificity,accuracy] = evaluator(predict_image,manual_image);
    
    avg_sens = avg_sens + sensitivity;
    avg_spec = avg_spec + specificity;
    avg_accu = avg_accu + accuracy;

    disp([num, ':   ', num2str(sensitivity), '       ', ...
       num2str(specificity), '       ', num2str(accuracy)]);

    % Logical to uint8
    a = uint8(predict_image .* 255);

    % Training
    % imwrite(a, "DRIVE\Training\1st_manual\" + num + "_predict.gif")

    % Test 1
    % imwrite(a, "DRIVE\Test\1st_manual\" + num + "_predict1.gif")

    % Test 2
    imwrite(a, "DRIVE\Test\2nd_manual\" + num + "_predict2.gif")

end

disp(" ")
disp(['AVG Sensitivity:    ', num2str(avg_sens/20)])
disp(['AVG Specificity:    ', num2str(avg_spec/20)])
disp(['AVG Accuracy:       ', num2str(avg_accu/20)])


