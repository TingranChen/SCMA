// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  hsG_0__0 (struct dummyq_struct * I1200, EBLK  * I1194, U  I670);
void  hsG_0__0 (struct dummyq_struct * I1200, EBLK  * I1194, U  I670)
{
    U  I1452;
    U  I1453;
    U  I1454;
    struct futq * I1455;
    struct dummyq_struct * pQ = I1200;
    I1452 = ((U )vcs_clocks) + I670;
    I1454 = I1452 & ((1 << fHashTableSize) - 1);
    I1194->I708 = (EBLK  *)(-1);
    I1194->I712 = I1452;
    if (I1452 < (U )vcs_clocks) {
        I1453 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1194, I1453 + 1, I1452);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I670 == 1)) {
        I1194->I714 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I708 = I1194;
        peblkFutQ1Tail = I1194;
    }
    else if ((I1455 = pQ->I1104[I1454].I726)) {
        I1194->I714 = (struct eblk *)I1455->I725;
        I1455->I725->I708 = (RP )I1194;
        I1455->I725 = (RmaEblk  *)I1194;
    }
    else {
        sched_hsopt(pQ, I1194, I1452);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
