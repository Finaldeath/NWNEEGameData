//::///////////////////////////////////////////////
//:: cac_rcvallgold
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Talke all of the NPC gold and give it to
    the PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    object oSpeaker = OBJECT_SELF;

    int iGold = GetGold(oSpeaker);

    TakeGoldFromCreature(iGold, oSpeaker, FALSE);
    GiveGoldToCreature(oPC, iGold);
}
