import bentoml
import numpy as np
import tensorflow as tf
from bentoml.io import JSON, Image
from retinaface import RetinaFace


class FaceDetectorRunnable(bentoml.Runnable):
    SUPPORTED_RESOURCES = ("nvidia.com/gpu", "cpu")
    SUPPORTS_CPU_MULTI_THREADING = True

    def __init__(self):
        self.model = tf.function(
            bentoml.tensorflow.load_model("retinaface:latest"),
            input_signature=(
                tf.TensorSpec(shape=[None, None, None, 3], dtype=np.float32),
            ),
        )

    # @bentoml.Runnable.method(batchable=True, batch_dim=0)
    @bentoml.Runnable.method(batchable=False)
    def detect_faces(self, image):
        return RetinaFace.detect_faces(img_path=image, model=self.model)


retinaface_runner = bentoml.Runner(
    name="face-detector", runnable_class=FaceDetectorRunnable
)

svc = bentoml.Service("face-detector", runners=[retinaface_runner])


@svc.api(input=Image(), output=JSON())
def detect_faces(input) -> dict:
    img_ndarray = tf.keras.utils.img_to_array(input)
    result = retinaface_runner.detect_faces.run(img_ndarray)

    return result
