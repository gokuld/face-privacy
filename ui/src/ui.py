import numpy as np
import pandas as pd
import PIL
import PIL.ImageFilter
import requests
import streamlit as st

debug = st.checkbox("Debug")

uploaded_image = st.file_uploader("Choose a photo.")

if uploaded_image:
    st.image(uploaded_image)
    st.write(uploaded_image.name, uploaded_image.size, uploaded_image.type)

    url = "http://api.privfacy.net:3000/detect_faces"
    files = {"input": (uploaded_image.name, uploaded_image, uploaded_image.type)}
    response = requests.post(url, files=files, timeout=120)

    detected_faces_df = pd.DataFrame(response.json()).transpose()

    if debug:
        st.write(detected_faces_df)

    pil_image = PIL.Image.open(uploaded_image)
    image = np.array(pil_image)

    st.write(image.shape)

    blur_mask = np.zeros_like(pil_image.convert("L"))

    # blur the faces
    for facial_area in detected_faces_df["facial_area"]:
        blur_mask[
            facial_area[1] : facial_area[3], facial_area[0] : facial_area[2]
        ] = 255

    pil_mask = PIL.Image.fromarray(blur_mask)
    pil_blurred_mask = pil_mask.filter(PIL.ImageFilter.GaussianBlur(10))
    pil_blurred_image = pil_image.filter(PIL.ImageFilter.GaussianBlur(10))
    if debug:
        st.image(pil_mask)
        st.image(pil_blurred_mask)
        st.image(pil_blurred_image)

    pil_blurred_faces_image = PIL.Image.composite(
        pil_blurred_image, pil_image, pil_blurred_mask
    )

    st.image(pil_blurred_faces_image)
