import requests

api_address = " https://newsapi.org/v2/everything?q=bitcoin&apiKey=2c31c7b82bb7458794de0c630b93e985"
json_data = requests.get(api_address).json()

ar = []


def news():
    for i in range(4):
        ar.append("Number " + str(i + 1) + "-> " + json_data["articles"][i]["title"] + " .")

    return ar
