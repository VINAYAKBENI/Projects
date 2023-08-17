import win32com.client as wincom

speaker = wincom.Dispatch("SAPI.SpVoice")

print('Welcome to Robo Speaker')
speaker.Speak('Welcome to Robo Speaker')

while True:
    s = input('Enter what you want to speak: ')
    if s == "q" or s == "Q" or s == "quit" or s == "Quit":
        print('Thank You for using Robo Speaker')
        speaker.Speak('Thank You for using Robo Speaker')
        break
    speaker.Speak(s)
