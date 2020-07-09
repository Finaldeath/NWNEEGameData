//::///////////////////////////////////////////////
//:: FileName con_ac_morisq1
//:: Set Moris quest to on
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:08:58 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "moris_quest", 1);
    SetLocked(GetObjectByTag("C1AR0700_C1AR0701A_EXIT"), FALSE);
    SetLocked(GetObjectByTag("C1AR0700_C1AR0701A2_EXIT"), FALSE);
}
