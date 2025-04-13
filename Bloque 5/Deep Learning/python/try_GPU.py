import tensorflow as tf

# Comprobar si TensorFlow puede acceder a la GPU
gpus = tf.config.list_physical_devices('GPU')
if gpus:
    # Modificar el número de GPUs que se utilizarán
    try:
        tf.config.set_visible_devices(gpus[0], 'GPU')
        logical_gpus = tf.config.list_logical_devices('GPU')
        print(len(gpus), "Physical GPUs,", len(logical_gpus), "Logical GPUs")
    except RuntimeError as e:
        # Capa de seguridad
        print(e)
else:
    print("No se encontraron GPUs disponibles")