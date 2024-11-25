# Copied from: https://xmitgcm.readthedocs.io/en/stable/demo_writing_binary_file.html 

import numpy as np
import xmitgcm
import matplotlib.pylab as plt

lon = np.arange(0,100,1)
lat = np.arange(0,100,1)
depth = np.arange(0,50,1)

shape,_,_ = np.meshgrid(lon,lat,depth)

pseudo = shape*0+1

xmitgcm.utils.write_to_binary(pseudo.flatten(), 'T.1c.bin')