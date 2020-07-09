//::///////////////////////////////////////////////
//:: nsp_a0_dead
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This on spawn event kills it's owner on load.
    Used in the Midnight Rose "Seige" cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
void main()
{
    object oSelf = OBJECT_SELF;
    effect eDead = EffectDeath(FALSE, FALSE);

    ExecuteScript("nw_default9", oSelf);

    SetIsDestroyable(FALSE, FALSE, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDead, oSelf);
}
