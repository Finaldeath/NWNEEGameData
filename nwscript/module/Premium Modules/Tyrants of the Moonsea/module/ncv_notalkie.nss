//::///////////////////////////////////////////////
//:: ncv_notalkie
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Special Conversation script that will remove
    an NPC's ability to speck based on a local
    variable.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
const string sMSG = "This character is too busy to speak with you right now.";

void main()
{
    object oPC = GetPCSpeaker();
    int iNoTalkie = GetLocalInt(OBJECT_SELF, "NO_TALKIE");

    if (iNoTalkie == FALSE)
    {
        ExecuteScript("nw_c2_default4", OBJECT_SELF);
    }
    else
    {
        SendMessageToPC(oPC, sMSG);
    }

}
