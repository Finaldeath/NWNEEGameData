//::///////////////////////////////////////////////
//:: nhb_potsc_hench
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Custom Hearbeat system for PotSC Henchmen.
    Hopefully this will prevent Clones from
    wandering around in appropriately during
    cutscenes.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
void main()
{
    object oAssociate = OBJECT_SELF;
    object oMaster = GetMaster(oAssociate);

    if ((GetCutsceneMode(oMaster) == FALSE)
        && (GetIsObjectValid(oMaster) == TRUE))
    {
        ExecuteScript("X0_CH_HEN_HEART", oAssociate);
    }
}
