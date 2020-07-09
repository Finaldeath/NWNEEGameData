////////////////////////////////////////////////////////////////////////////////
// dla_jt_tilt_end
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
   End a tilt round or call the ending cutscene
*/
////////////////////////////////////////////////////////////////////////////////
// Created By: Dave Musser (Syrsnein)
// Created On: 12 July 2006
////////////////////////////////////////////////////////////////////////////////
/*
 Change History
 Date
 year/mm/dd | Author     | Change
 -----------+------------+------------------------------------------------------
 */

#include "dla_i0_joust"

//Syrsnein, 11 June 2006: Moved code to this function to end the current tilt.
void main()
{
    object oPC = OBJECT_SELF;
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    float fCueTime = 0.0;

    if (!GetCutsceneMode(oPC))
        SetCutsceneMode(oPC);

    // Check for match end.  If the match is over, end the cutscene
    int iPCScoreMatch = DLA_GetScoreOnMatch(oPC, FALSE);
    int iOPScoreMatch = DLA_GetScoreOnMatch(oPC, TRUE);
    if (DLA_GetOutcome(oOP, DLA_OUTCOME_INJURED))
    {// Let the player know their hit was unchivalrous
        DelayCommand(fCueTime+=0.5, FloatingTextStringOnCreature("Your hit was unchivalrous!  Your reputation may have been damaged!", oPC, FALSE));
    }// Let the player know their hit was unchivalrous
    if((iPCScoreMatch >= 3 || iOPScoreMatch >= 3) && (iPCScoreMatch != iOPScoreMatch))
    {// Match is over
        DelayCommand(fCueTime+=0.1, ExecuteScript("dla_jt_cutsc_end", oPC));
        return;
    }// Match is over
    else
    {// Clear any old passing remarks and return the jousters to their starting points
        DeleteLocalInt(oOP, "nJoustRemarkIndex");
        DeleteLocalInt(oOP, "nJoustRemarkGENeutral");
        DeleteLocalInt(oOP, "nJoustRemarkLCNeutral");
        // Set the player as returning to starting point
        DeleteLocalInt(oPC, DLA_VAR_JOUST_ON);
        SetLocalInt(oPC, DLA_VAR_JOUST_RETURN, TRUE);

        // Lets jump to our end points and walk back to each other to exchange
        // a word or two.
        AssignCommand(oOP, ClearAllActions(TRUE));
        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(fCueTime, AssignCommand(oOP, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT2")))));
        DelayCommand(fCueTime+=0.01, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT2")))));
        DelayCommand(fCueTime+=0.1, AssignCommand(oOP, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT1")), FALSE)));
        DelayCommand(fCueTime+=0.01, AssignCommand(oPC, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT1")), FALSE)));
        DelayCommand(fCueTime+=1.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
    }// Clear any old passing remarks and return the jousters to their starting points
}
