//::///////////////////////////////////////////////
//:: pcl_a3_design
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has unlocked a portal
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    object oItem = GetFirstItemInInventory(oSelf);
    object oWayPoint = GetNearestObjectByTag("A3_POSITION", oSelf, 0);

    location lWP = GetLocation(oWayPoint);
    int iSolved = GetLocalInt(oSelf, "SOLVED");

    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSolve = EffectVisualEffect(VFX_FNF_WORD);

    string sTag = GetLocalString(oSelf, "ITEM_TAG");
    string sMonster = GetLocalString(oSelf, "MONS_RESREF");


    while (GetIsObjectValid(oItem) == TRUE)
    {
        if (GetTag(oItem) == sTag)
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSolve, lWP);
            DestroyObject(oItem);
            ExecuteScript("exe_a3_huntinc", oPC);
        }
        else
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lWP);
            CreateObject(OBJECT_TYPE_CREATURE, sMonster, lWP);
        }

        oItem = GetNextItemInInventory(oSelf);
    }
}
