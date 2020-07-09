// January 2006
// B W-Husey
// Changes the Hawklin version found in the castle when the PC goes off to the tournament.

#include "dla_i0_joust"
#include "cu_functions"

void main()
{
    object oPC = GetExitingObject();
    if (GetIsDefPC(oPC))
    {
        if (GetLocalInt(oPC,"nHawklinFin6")>0 && GetLocalInt(oPC,"nMainPlot")==6) //added mainplot as a check as we were getting strange behaviour
        {
            //get rid of other Hawklin instances
            object oHawk1 = GetObjectByTag("Hawklin2");
            object oHawk2 = GetObjectByTag("SGHCastle");
            AssignCommand(oHawk1,SetIsDestroyable(TRUE,FALSE));
            AssignCommand(oHawk2,SetIsDestroyable(TRUE,FALSE));
            SetPlotFlag(oHawk1,FALSE);
            DestroyObject(oHawk1);
            SetPlotFlag(oHawk2,FALSE);
            DestroyObject(oHawk2);
            //set plot state and ensure 1st tourney state = done
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_DONE);//set to 2nd tourney
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_DONE);//set to 2nd tourney
            AllParty("nMainPlot",oPC,7);
        }
    }
}


