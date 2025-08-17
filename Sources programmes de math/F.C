/* f.f -- translated by f2c (version 19940714).
   You must link the resulting object file with the libraries:
	-lf2c -lm   (in that order)
*/

#include "f2c.h"

/* Table of constant values */

static integer c__1 = 1;

/* Main program */ MAIN__()
{
    /* Format strings */
    static char fmt_100[] = "(i4)";

    /* Builtin functions */
    integer s_wsfe(), do_fio(), e_wsfe();

    /* Local variables */
    static integer a;

    /* Fortran I/O blocks */
    static cilist io___2 = { 0, 6, 0, fmt_100, 0 };


    a = 1;
    s_wsfe(&io___2);
    do_fio(&c__1, (char *)&a, (ftnlen)sizeof(integer));
    e_wsfe();
} /* MAIN__ */

/* Main program alias */ int f_ () { MAIN__ (); }
