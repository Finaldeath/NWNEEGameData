// February 2006
// B W-Husey
// Entering object performs a search check to see if the boulder can be pulled from the wall.
#include "CU_FUNCTIONS"

void main()
{
    object oPC = GetEnteringObject();
    int nBonus;

    if (GetDetectMode(oPC) == DETECT_MODE_ACTIVE)    nBonus = 5;
    if (GetHasFeat(FEAT_STONECUNNING,oPC))    nBonus = 5;
    int nCheck = d20()+GetSkillRank(SKILL_SEARCH,oPC)+nBonus;
    if (nCheck>22)
    {
        AllParty("nPFUSecFound",oPC,1);
        AssignCommand(oPC,SpeakString("There's a breeze here..."));
        DestroyObject(OBJECT_SELF);
    }

}


