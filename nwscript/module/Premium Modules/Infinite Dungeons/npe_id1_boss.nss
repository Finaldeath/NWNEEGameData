//::////////////////////////////////////////////////////////////////////////////
//:: npe_id1_boss
//:: Copyright (c) 2001 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Default On Perception script with some additional coding to make the bosses
    of Infinite Dungeons say something to the player as the battle begins.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11, 2003
//:: Modified By: Grant Mackay
//:: Modified On: Sep 22, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"

void main()
{
    object oDungeon = GetCurrentDungeon();
    object oPerceived = GetLastPerceived();

    // If the perceived object is a player speak the one liner.
    if ((GetIsPC(oPerceived) == TRUE) && (GetLocalInt(oDungeon, "bBossDetect") == FALSE))
    {
        // Set the perceived flag so the boss doesn't talk each time.
        SetLocalInt(oDungeon, "bBossDetect", TRUE);

        SpeakOneLinerConversation();
    }

    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}
