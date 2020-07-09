//::///////////////////////////////////////////////////
//::B G P Hughes
// Replacement levelling function
// 5th August 2006
// dla_athenchlev
// modified 4th October by Vulcano
//::///////////////////////////////////////////////////

#include "x0_i0_henchman"
#include "dla_i0_horse"
#include "x0_inc_henai"

void main()
{
    object oPC = GetFirstPC();
    int nLevel = GetHitDice(oPC);
    int x,i=1;
    object oHench = GetHenchman(oPC,i);
    while(GetIsObjectValid(oHench))
    {
        if(GetRacialType(oHench)!=RACIAL_TYPE_ANIMAL)
        {
            x=LevelUpHenchman(oHench);
            DLA_RefreshMovementSpeed(oHench);
            //SendMessageToPC(oPC, GetName(oHench)+" level result = "+IntToString(x));
        }
        i++;
        oHench = GetHenchman(oPC,i);
    }
}
