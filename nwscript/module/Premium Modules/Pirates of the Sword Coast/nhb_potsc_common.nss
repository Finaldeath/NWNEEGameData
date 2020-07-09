//::///////////////////////////////////////////////
//:: Name nhb_potsc_common
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On HeartBeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetFirstPC();
    object oSelf = OBJECT_SELF;
    int iReputation;

    iReputation = GetReputation(oSelf, oPC);
    if (iReputation != 50)
    {
        ClearPersonalReputation(oPC, oSelf);
    }

    iReputation = GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPC);
    if (iReputation != 50)
    {
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oPC);
    }

    return;
}
