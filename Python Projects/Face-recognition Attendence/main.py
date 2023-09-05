import cv2
import csv
import face_recognition
from datetime import datetime

import numpy as np


video_capture=cv2.VideoCapture(0)

papa=face_recognition.load_image_file("faces/papa.jpeg")

papa_encodding=face_recognition.face_encodings(papa)[0]

vin=face_recognition.load_image_file("faces/vin.jpeg")

vin_encodding=face_recognition.face_encodings(vin)[0]

face=[papa_encodding,vin_encodding]

names=['papa','Vinayak']

students=names.copy()

face_loc=[]
face_encoding=[]

now =datetime.now()
curr_date=now.date()


f=open(f'{curr_date}.csv','w+',newline="")
lnwriter=csv.writer(f)

while True:
    _ , frame=video_capture.read()
    small_frame=cv2.resize(frame,(0,0),fx=0.25,fy=0.25)
    rgb_small_frame=cv2.cvtColor(small_frame,cv2.COLOR_BGR2RGB)

    face_loc=face_recognition.face_locations(rgb_small_frame)
    face_encoding=face_recognition.face_encodings(rgb_small_frame,face_loc)

    for faces in face_encoding:
        matches=face_recognition.compare_faces(np.array(face),np.array(face_encoding))
        face_dist=face_recognition.face_distance(np.array(face),np.array(face_encoding))
        best_match_index=np.argmin(face_dist)

        if(matches[best_match_index]):
            name=face[best_match_index]
        
        if name in names:
            font=cv2.FONT_HERSHEY_SCRIPT_SIMPLEX
            fontcolor=(255,0,0)
            fontscale=1.5
            bottomleft=(10,100)
            thickness=3
            linetype=2

            cv2.putText(frame,name+'Present',bottomleft,font,fontscale,fontcolor,thickness,linetype)

    cv2.imshow("attendence",frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break
video_capture.release()
cv2.destroyAllWindows()
f.close()

