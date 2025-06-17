Feature:
Call Random data
Background: Run
    * def datagen = Java.type('Helpers.DataGenerator')
    * def dummyName = datagen.getUserName();
    * print dummyName