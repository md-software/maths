"""
Algorithme à base d'une suite géométrique pour calculer les décimales de PI

Référence: http://www.pi314.net/fr/grenier.php 
"""
import sys 
from math import sqrt

xkmoins1 = 2
xk = 2*sqrt(2)

sav = xkmoins1
for i in range(100):
    xkplus1 = xk * sqrt((2*xk)/(xk+xkmoins1))
    if abs(xkplus1-xk) < 0.0000000000000001:
        break
    sav = xk
    xk = xkplus1
    xkmoins1 = sav

print(xkplus1)