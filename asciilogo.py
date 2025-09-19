import pyfiglet
import os
text = input()
f = pyfiglet.figlet_format(text, font="slant")
with open(os.path.expanduser("~temp.txt"), "w") as file:
    file.write(f)
