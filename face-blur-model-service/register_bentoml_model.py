import bentoml
from retinaface.model import retinaface_model

model = retinaface_model.build_model()

bentoml.tensorflow.save_model(name="retinaface", model=model)

print("Saved retinaface model to BentoML registry")
