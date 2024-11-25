# Does what it says on the tin
import os
import cv2 
import re

numbers = re.compile(r'(\d+)')
def numericalSort(value):
    parts = numbers.split(value)
    parts[1::2] = map(int, parts[1::2])
    return parts

def generate_video():
    figs = sorted(os.listdir('./plume_figs'),key=numericalSort)
    frame = cv2.imread('./plume_figs/'+figs[0])
    height, width, layers = frame.shape
    fourcc = cv2.VideoWriter_fourcc(*'mp4v') 
    video = cv2.VideoWriter('plume1.mp4', fourcc, 1, (width, height))
    for fig in figs:
        img = cv2.imread('./plume_figs/'+fig)
        video.write(img)
    cv2.destroyAllWindows()
    video.release()

if __name__ == "__main__":
    generate_video()