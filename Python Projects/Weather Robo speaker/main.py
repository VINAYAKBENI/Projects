import requests
import json
import win32com.client  as wincom

speak = wincom.Dispatch("SAPI.SpVoice")

city=input('Enter the name of city: ')

url=f"https://api.weatherapi.com/v1/current.json?key=2d22f90e270a43da982202509231708&q={city}"

r=requests.get(url)

# weatherdict=json.loads(r.text)
weatherdict=r.json()
print(f"current weather of {city} is {weatherdict['current']['temp_c']} degree celsius")
speak.Speak(f"Current Weather of {city} is {weatherdict['current']['temp_c']} degree celsius")

