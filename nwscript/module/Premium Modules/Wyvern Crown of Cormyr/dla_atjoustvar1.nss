/*
Everything will be decided via the outcome of picking your def and attack positions

variable reference
DLA_JOUST_DEFPOS <--- defensive position
1.lower helm
2.lean right
3.lean left
4.steady seat
5.shield high
6.shield low

DLA_JOUST_AIMPOS <--- Attack Aim
1.helm
2.DC
3.CP
4.SC
5.DF
6.FP
7.SF
8.Base

created by: Takamura 11/01/2005
*/
#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    if (DLA_GetAimPos(oPC) == 0)
        DLA_SetAimPos(oPC, 1);
    else
        DLA_SetDefPos(oPC, 1);

}
