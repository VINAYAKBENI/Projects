import pyttsx3 as kite
import speech_recognition as sr
from selenium_web import *
from YT_AUTO import *
from google import *
from News import *
import randfacts
from jokes import *
from weather import *
import datetime

start = kite.init()
start.setProperty('rate', 200)
voices = start.getProperty('voices')
start.setProperty('voice', voices[1].id)


def speak(text):
    start.say(text)
    start.runAndWait()


def wishme():
    hour = int(datetime.datetime.now().hour)
    if hour > 0 and hour < 12:
        return ("GOOD MORNING")
    elif hour >= 12 and hour < 16:
        return ("GOOD AFTERNOON")
    else:
        return ("GOOD EVENING")


today = datetime.datetime.now()
r = sr.Recognizer()
t = 1
s = 0

print("Hello sir, " + wishme())
print("Myself KITE your voice assistant .")
speak("Hello sir, " + wishme())
speak("Myself KITE your voice assistant .")
print("Today is  " + today.strftime("%d") + " of " + today.strftime("%B") +
      " And its is currently  " + today.strftime("%I") + today.strftime("%M") + today.strftime("%p"))
speak("Today is  " + today.strftime("%d") + " of " + today.strftime("%B") +
      " And its is currently  " + today.strftime("%I") + today.strftime("%M") + today.strftime("%p"))
print("How are you ?")
speak("How are you ?")

with sr.Microphone() as source:
    r.energy_threshold = 10000
    r.adjust_for_ambient_noise(source, 1.2)
    print("Listening..")
    audio = r.listen(source)
    text = r.recognize_google(audio)
    print(text)
print()
if "what" and "about" and "you" or " i am fine" or "i am good":
    speak("I am also having a good day Sir ")


while t > 0:
    print("What can a do for you Sir ?")
    speak("What can a do for you Sir ?")
    print()

    with sr.Microphone() as source:
        r.energy_threshold = 10000
        r.adjust_for_ambient_noise(source, 1.2)
        print("Listening..")
        audio = r.listen(source)
        text2 = r.recognize_google(audio)
    print()

    if "information" in text2:
        speak(" you need information related which topic ? ")
        print(" you need information related which topic ? ")

        with sr.Microphone() as source:
            r.energy_threshold = 10000
            r.adjust_for_ambient_noise(source, 1.2)
            print("Listening..")
            audio = r.listen(source)
            inform = r.recognize_google(audio)
            speak("searching {} in wikipedia".format(inform))
            print("searching {} in wikipedia".format(inform))

        assist = info()
        assist.get_info(inform)
        print("THANK YOU for using me")
        speak("THANK YOU for using me")
        t = 0
    elif "play" and "video" in text2:
        speak(" you want me to play which video ? ")
        print(" you want me to play which video ? ")

        with sr.Microphone() as source:
            r.energy_threshold = 10000
            r.adjust_for_ambient_noise(source, 1.2)
            print("Listening..")
            audio = r.listen(source)
            vid = r.recognize_google(audio)
        speak("playing {} on youtube".format(vid))
        print("playing {} on youtube".format(vid))

        assist = music()
        assist.play(vid)
        print("THANK YOU for using me")
        speak("THANK YOU for using me")
        t = 0

    elif "open" and "website" in text2:
        speak("you want me show which website ? ")
        print("you want me show which website ? ")

        with sr.Microphone() as source:
            r.energy_threshold = 10000
            r.adjust_for_ambient_noise(source, 1.2)
            print("Listening..")
            audio = r.listen(source)
            site = r.recognize_google(audio)
        speak("opening {} on Google".format(site))
        print("opening {} on Google".format(site))

        assist = goo()
        assist.ser(site)
        print("THANK YOU for using me")
        speak("THANK YOU for using me")
        t = 0
    elif "news" in text2:
        arr = news()
        print("Sure sir, i will tell you some latest news")
        speak("Sure sir, i will tell you some latest news")
        print()
        for i in range(len(arr)):
            print(arr[i])
            speak(arr[i])
        print("THANK YOU for using me")
        speak("THANK YOU for using me")

    elif "fact" in text2:
        while s == 0:
            x = randfacts.getFact()
            print("Did you know that, " + x)
            speak("Did you know that," + x)
            break

    elif "joke" in text2:
        arr = joke()
        print(text2)
        speak("Sure sir ,")
        print(arr[0])
        speak(arr[0])
        print(arr[1])
        speak(arr[1])

    elif "weather" in text2:
        speak("Temperature in New Delhi is ," + str(temp()) + "degree celsius, and with " + str(des()))

    elif "stop" in text2:
        print("THANK YOR SIR FOR USING ME")
        speak("THANK YOR SIR FOR USING ME")
        t = 0
    elif "feature" or "what" and "can" and "do" in text2:
        print("1. GIVE YOU INFORMATION")
        speak("1. GIVE YOU INFORMATION")
        print("2. PLAY A VIDEO ")
        speak("2. PLAY A VIDEO ")
        print("3. OPEN A WEBSITE ")
        speak("3. OPEN A WEBSITE ")
        print("4. GIVE YOU NEWS ")
        speak("4. GIVE YOU NEWS ")
        print("5. CRACK A JOKE ")
        speak("5. CRACK A JOKE ")
        print("6. TELLS WEATHER REPORT ")
        speak("6. TELLS WEATHER REPORT ")

    else:
        speak("wrong input")
        t = 0
