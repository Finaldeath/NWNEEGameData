//::///////////////////////////////////////////////
//:: tcl_a1_trogenter
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This Door object Transition Click script is
    for the entrance to the Troglodyte cavern.
    It handles the routing of players into the
    areas based on the global plot state of the
    troglodytes.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oClicker = GetClickingObject();
    object oWPStench = GetWaypointByTag("wp_a1trog01");
    object oWPTrogBase = GetWaypointByTag("wp_a1trog02");
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    //Nest it all within a PC check to prevent hostiles from entering.
    if (GetIsPC(oClicker) == TRUE)
    {
        //Standard blockade against possessed familiars.
        if (GetIsPossessedFamiliar(oClicker) == TRUE)
        {
            string sMessage = "You dare not stray far from your master.";
            FloatingTextStringOnCreature(sMessage, oClicker);
        }
        // the player has not defeated garm, go to the Stench Cutscene
        else if (iTrogPlot < 70)
        {
            //SendMessageToPC(oClicker, "Transitioning to cutscene");
            AssignCommand(oClicker, ClearAllActions(TRUE));
            AssignCommand(oClicker, JumpToObject(oWPStench));
        }
        else // Garm is defeated, the player can enter the cave proper
        {
            //SendMessageToPC(oClicker, "Transitioning to Area");
            AssignCommand(oClicker, ClearAllActions(TRUE));
            AssignCommand(oClicker, JumpToObject(oWPTrogBase));
        }
    }
}
