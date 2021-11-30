import nltk
from nltk.chat.util import Chat,reflections
reflections={"i am":"you are","i":"you","your":"my","you":"me","me":"you","I'm":"you are","i'd":"you would","i've":"you have","i'll":"you will","my":"your","you are":"i'm","you were":"I was"}
pairs=[
[
    r"my name is(.*)",["Hello %1, How are you today?",]
],
[
    r"Hi|Hey|hello",["Hello","Hey There",]
],
[
        r"How are you",
        ["I am doing good, what about you?"]
],
[
    r"What is your name?",["I am Talking Bot, created by Husn Ara"]
],
[
    r"sorry(.*)",["It's alright","It's Ok,never mind"]
],
[
    r"I am fine",["Great to hear that,How can I  help you?",]
],
[
    r"My phone network is slow",["you can restart your phone and connect again"]
],
[
    r"Quit",["Bye take care, see you soon","It was nice talking with you"]
],
[
    r"(.*)sport person?",["Sachin","sania","virat"]
]
]


def chat():
    print("Hi! I am Talking Bot.. Created by Husn Ara")
    chat=Chat(pairs,reflections)
    chat.converse()
    
if __name__ == '__main__':
    chat()