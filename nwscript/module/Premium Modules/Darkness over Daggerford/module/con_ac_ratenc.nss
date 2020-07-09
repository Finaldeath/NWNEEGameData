//::///////////////////////////////////////////////
//:: FileName con_ac_ratenc
//:: Set rat encounters active
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 2:50:30 PM
//:://////////////////////////////////////////////

//#include "hf_in_cutscene"

void main()
{
    int iC = 1;
    object oPC = GetPCSpeaker();
    object oW = GetObjectByTag("wp_ac_rooexit");
    object oW2 = GetObjectByTag("wp_ac_roostart");

    SetLocalInt(OBJECT_SELF, "HF_DISABLE_AM", 1);
    ClearAllActions();
    ActionForceMoveToObject(oW, TRUE, 1.0, 10.0);
    ActionJumpToObject(oW2);
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "HF_DISABLE_AM", 0));
    object oEnc = GetNearestObjectByTag("enc_ac_smallrats", oPC, iC);
    SetLocalInt(OBJECT_SELF, "ac_roo_2ndcave", 2);
    while(GetIsObjectValid(oEnc))
    {
        SetEncounterActive(TRUE, oEnc);
        iC++;
        oEnc = GetNearestObjectByTag("enc_ac_smallrats", oPC, iC);
    }
//CutsceneNextShot();
}
