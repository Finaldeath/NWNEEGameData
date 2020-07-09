//::///////////////////////////////////////////////
//:: pus_a3_trans
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Generic Area Transition script.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
void main()
{
    object oUser = GetLastUsedBy();
    object oDoor = OBJECT_SELF;
    string sWay = GetLocalString(oDoor, "TARGET_DEST");
    object oTarget = GetObjectByTag(sWay);

    //Restrict Possessed Familiars
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        AssignCommand(oUser, JumpToObject(oTarget));
    }
}
