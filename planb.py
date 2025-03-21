from ultralytics import YOLO

# Load the trained model
model = YOLO("potholes_model/potholes_model.pt")

# Export to CoreML with INT8 quantization and NMS
model.export(format="coreml", int8=True, nms=True)
