"""
Algorithme compte-gouttes pour calculer les décimales de PI

Référence: https://www.lyceedadultes.fr/sitepedagogique/documents/math/mathTermSspe/01_Multiples_division_euclidienne_congruence/01_cours_compte_gouttes_pi.pdf 
"""
import sys 
from math import floor, ceil, pi

raw_pi2400decimales = "3,141 592 653 589 793 238 462 643 383 279 502 884 197 169 399 375 105 820 974 944 592 307 816 406 286 208 998 628 034 825 342 117 067 982 148 086 513 282 306 647 093 844 609 550 582 231 725 359 408 128 481 117 450 284 102 701 938 521 105 559 644 622 948 954 930 381 964 428 810 975 665 933 446 128 475 648 233 786 783 165 271 201 909 145 648 566 923 460 348 610 454 326 648 213 393 607 260 249 141 273 724 587 006 606 315 588 174 881 520 920 962 829 254 091 715 364 367 892 590 360 011 330 530 548 820 466 521 384 146 951 941 511 609 433 057 270 365 759 591 953 092 186 117 381 932 611 793 105 118 548 074 462 379 962 749 567 351 885 752 724 891 227 938 183 011 949 129 833 673 362 440 656 643 086 021 394 946 395 224 737 190 702 179 860 943 702 770 539 217 176 293 176 752 384 674 818 467 669 405 132 000 568 127 145 263 560 827 785 771 342 757 789 609 173 637 178 721 468 440 901 224 953 430 146 549 585 371 050 792 279 689 258 923 542 019 956 112 129 021 960 864 034 418 159 813 629 774 771 309 960 518 707 211 349 999 998 372 978 049 951 059 731 732 816 096 318 595 024 459 455 346 908 302 642 522 308 253 344 685 035 261 931 188 171 010 003 137 838 752 886 587 533 208 381 420 617 177 669 147 303 598 253 490 428 755 468 731 159 562 863 882 353 787 593 751 957 781 857 780 532 171 226 806 613 001 927 876 611 195 909 216 420 198 938 095 257 201 065 485 863 278 865 936 153 381 827 968 230 301 952 035 301 852 968 995 773 622 599 413 891 249 721 775 283 479 131 515 574 857 242 454 150 695 950 829 533 116 861 727 855 889 075 098 381 754 637 464 939 319 255 060 400 927 701 671 139 009 848 824 012 858 361 603 563 707 660 104 710 181 942 955 596 198 946 767 837 449 448 255 379 774 726 847 104 047 534 646 208 046 684 259 069 491 293 313 677 028 989 152 104 752 162 056 966 024 058 038 150 193 511 253 382 430 035 587 640 247 496 473 263 914 199 272 604 269 922 796 782 354 781 636 009 341 721 641 219 924 586 315 030 286 182 974 555 706 749 838 505 494 588 586 926 995 690 927 210 797 509 302 955 321 165 344 987 202 755 960 236 480 665 499 119 881 834 797 753 566 369 807 426 542 527 862 551 818 417 574 672 890 977 772 793 800 081 647 060 016 145 249 192 173 217 214 772 350 141 441 973 568 548 161 361 157 352 552 133 475 741 849 468 438 523 323 907 394 143 334 547 762 416 862 518 983 569 485 562 099 219 222 184 272 550 254 256 887 671 790 494 601 653 466 804 988 627 232 791 786 085 784 383 827 967 976 681 454 100 953 883 786 360 950 680 064 225 125 205 117 392 984 896 084 128 488 626 945 604 241 965 285 022 210 661 186 306 744 278 622 039 194 945 047 123 713 786 960 956 364 371 917 287 467 764 657 573 962 413 890 865 832 645 995 813 390 478 027 590 099 465 764 078 951 269 468 398 352 595 709 825 822 620 522 489 407 726 719 478 268 482 601 476 990 902 640 136 394 437 455 305 068 203 496 252 451 749 399 651 431 429 809 190 659 250 937 221 696 461 515 709 858 387 410 597 885 959 772 975 498 930 161 753 928 468 138 268 683 868 942 774 155 991 855 925 245 953 959 431 049 972 524 680 845 987 273 644 695 848 653 836 736 222 626 099 124 608 051 243 884 390 451 244 136 549 762 780 797 715 691 435 997 700 129 616 089 441 694 868 555 848 406 353 422 072 225 828 488 648 158 456 028 50"
# supprimer les espaces
pi2400decimales = raw_pi2400decimales.replace(" ","")

#nb_chiffres = 11
nb_chiffres = input("Nombre de chiffres: ")
try:
    nb_chiffres = int(nb_chiffres) # Tentative de conversion en entier
    assert nb_chiffres > 0
except ValueError:
    print("Vous n'avez pas saisi un nombre.")
    sys.exit(1)
except AssertionError:
    print("Le nombre saisi doit être > à 0.")
    sys.exit(2)
    
# initialisations
E = 0
J = 1
N = 4*nb_chiffres # N=4*nb de décimales voulues
L1 = [2]*(N+1)
print("nb chiffres ('3,' compris): ", nb_chiffres, " - N boucles =", N)

pi_calcule = ""
#print("pi calculé avec {} chiffres = ".format(nb_chiffres), end='')

current_index = 0

for I in range(1, floor(N / 4)+1):
    B = 2*N - 1
    R = 0
    K = N
    while K > 0:
        R = R + 10*L1[K]
        L1[K] = R - B*floor(R / B)
        R = floor(R / B)
        B = B - 2
        K = K - 1
        if K != 0:
            R = R*K

    F = E + floor(R / 10)
    #print("B:{} K: {} R:{} E:{} F:{}".format(B,K,R,E,F))
    if F > 9:
        x = 1
        while True:
            # On incrémente le digit précédent
            list1 = list(pi_calcule)
            previous_F = list1[current_index-x]
            #print("F>9 !!!: ", F, current_index, x, previous_F)
            #print('\b', int(previous_F)+1, sep='', end='')
            # on corrige la chaine déjà constituée
            if int(previous_F)+1 > 9:
                list1[current_index-x] = '0'
            else: 
                list1[current_index-x] = str(int(previous_F)+1)
            pi_calcule = ''.join(list1)
            if int(previous_F)+1 <= 9:
                break
            x += 1
        F -= 10
    #print(F, end='')
    pi_calcule += str(F)
    current_index += 1
    if J == 1:
        #print(",", end='')
        pi_calcule += ","
        current_index += 1
        J = J + 1

    E = R - 10*floor(R / 10)
    J = J + 1

print("pi calculé avec {} chiffres = {}".format(nb_chiffres, pi_calcule))

pi_nb_chiffres = pi2400decimales[:nb_chiffres+1]
print("\npi exact   avec {} chiffres = {}".format(nb_chiffres, pi_nb_chiffres))

if pi_nb_chiffres != pi_calcule:
    print("*** ERREUR: pi calculé est faux :-(")
else:
    print("Calcul correct :-)")
