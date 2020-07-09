//::///////////////////////////////////////////////
//:: cac_giveallgold
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Talke all of the speakers gold and give it to
    the Bandit.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    object oSpeaker = OBJECT_SELF;

    int iGold = GetGold(oPC);

    TakeGoldFromCreature(iGold, oPC, FALSE);
    GiveGoldToCreature(oSpeaker, iGold);
}
