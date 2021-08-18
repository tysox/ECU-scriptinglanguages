#!/usr/bin/python3

#Understanding how to use itertools to create a continuously alphabetic list came from reading: https://stackoverflow.com/questions/29351492/how-to-make-a-continuous-alphabetic-list-python-from-a-z-then-from-aa-ab-ac-e

import hashlib
import itertools
from string import ascii_lowercase    #in reality I would use "printable" in place of "ascii_lowercase", but it damaticlally increases the time taken to brute-force. For the sake of time with regard to demonstrating the successful implementation of this script, "ascii_lowercase" is used instead.
from itertools import product

#hidden password hash
#passwordHash = "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824" #password = hello  <= Takes longer.
passwordHash = "8b7df143d91c716ecfa5fc1730022f6b421b05cedee8fd52b1fc65a96030ad52" #password = blah

#Create a function that will cycle through a set of single characters, then a set of two characters, then three, etc.
def iter_all_strings():
    for size in itertools.count(1):
        for word in itertools.product(ascii_lowercase, repeat=size):
            yield "".join(word)         #"yield" defines this as a generator function. i.e.: one that will return a subsequent value everytime it is called on (not the same value).

for word in iter_all_strings():
    wordlistHash = hashlib.sha256(word.encode("utf-8")).hexdigest()     #creates a hash of the current 'word' variable. (This block of code was copied from the original "dictionaryAttack.py" script).
    print(f"Trying password {word}:{wordlistHash}")

    #if the hash is the same as the correct password's hash then we have cracked the password!
    if(wordlistHash == passwordHash):
        print(f"Password has been cracked! It was: {word}")
        break