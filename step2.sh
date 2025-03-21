model_name="custom_model"

# In case the model already exists, remove it
rm -r $model_name

# Create model directory
mkdir $model_name

# find in which train folder is best.pt located in: train, train2, ...
train="train"

cp runs/detect/$train/weights/best.pt $model_name/$model_name.pt
cp -r runs/detect/$train $model_name
cp -r runs/detect/predict $model_name

# Create a zip file with the model and training data
cd $model_name
zip $model_name.zip $model_name.pt
zip -r $model_name.zip $train
zip -r $model_name.zip predict

# Return to the previous directory
cd ..

# Export model to CoreML
yolo export model=$model_name/$model_name.pt format=coreml int8=True nms=True

# call the python script to export .pt model to coreml model
# python planb.py

# Create a CoreML model directory
# mkdir coreMLmodel

# Zip the CoreML model
# zip -r coreMLmodel/$model_name.mlpackage.zip $model_name/$model_name.mlpackage

