//::///////////////////////////////////////////////
//:: con_potsc_dmchk
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if a DM is present
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    object oArea = GetArea(oPC);
    object oModule = GetModule();
    object oCursor;

    int iDM_NPCCONV_OFF = GetLocalInt(oModule, "POTSC_DM_CONVOFF");
    int iResult = FALSE;

    string sMSG = "";

    // If there's a DM in the game and the CONVOFF option is set
    // Don't let the NPC Speak;
    oCursor = GetFirstPC();
    while ((GetIsObjectValid(oCursor) == TRUE)
      && (iDM_NPCCONV_OFF == TRUE))
    {
        if ((GetIsDM(oCursor) == TRUE) && (iDM_NPCCONV_OFF == TRUE))
        {
            // Notify the DM that a player has attempted to initate Dialog with an NPC.
            sMSG = "The Player '" + GetPCPlayerName(oPC) + "' has attempted to ";
            sMSG += "speak to NPC '" + GetName(oNPC) + "' ";
            sMSG += "in area '" + GetName(oArea) + "'";

            FloatingTextStringOnCreature(sMSG, oCursor, FALSE);
            iResult = TRUE;
        }

        oCursor = GetNextPC();
    }

    return iResult;
}
