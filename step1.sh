#!/bin/bash

# Define paths for classes.txt and data.yaml
path_to_classes_txt='custom_data/classes.txt'
path_to_data_yaml='data.yaml'
model="yolo11s.pt"
epochs=60
imgsz=640

# Ensure the data.yaml is created by calling the Python script
python3 dontrun.py "$path_to_classes_txt" "$path_to_data_yaml"

# In case run/train already exists
rm -r runs

# Perform YOLO inference and export model
echo "Start training the model ..."
yolo detect train data=data.yaml model=$model epochs=$epochs imgsz=$imgsz

# Test the model
yolo detect predict model=runs/detect/train/weights/best.pt source=custom_data/valid/images save=True
