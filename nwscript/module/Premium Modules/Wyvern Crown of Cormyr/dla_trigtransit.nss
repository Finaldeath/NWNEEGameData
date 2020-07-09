// B G P Hughes (B W-Huesy)
// August 2005
// Area transition script for use on transitions that take the party from one area to another
// The destinations available are controlled through the conversation dialogue variables
// as is the time and food (gold) cost of travel, which is dependant on whether the PC
// is on foot or mounted.
// Before the dialogue is fired up, this script checks the local variables and adjusts some of them dependant
// on the plot state of other variables, listed below:
/*
    nMainPlot =     1, no travel to any Wyvernwater, any Polter, Hullack Forest or Barrows
    nMainPlot =     2, no travel to any Wyvernwater, any Polter. Tournaments.
    nMainPlot =     3, no travel to any Wyvernwater, Hullack Forest or Barrows. Tournaments.
    nMainPlot =     4, no travel to any Polter, Hullack Forest or Barrows, Tournaments, or Wyvernwater Castle.
    nMainPlot =     5, no travel to any Polter, Hullack Forest or Barrows,Tournaments.
    nMainPlot =     6, Only Thunderstone and Lake Wyvernwater.
    nMainPlot =     7, Only Thunderstone, Lake Wyvernwater and Tournaments.
    nMainPlot =     8, No overland travel.
    In any event some areas (farm, morfen, on the road) are only accessible from the testing conversation
    as they are one way in the module.
*/


void main()
{
//    object oPC = GetClickingObject();
    object oPC = GetEnteringObject();
    object oTrans = GetObjectByTag("HFWest");
    if (GetIsPC(oPC)==TRUE)//PC, DM etc only
    {
        int nPlot = GetLocalInt(oPC,"nMainPlot");
        //Debug line *********************
    //    SendMessageToPC(oPC,"Area Transition Check of Plot variable: "+IntToString(nPlot));
        if (GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==2) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",1);
        if (GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==2)  SetLocalInt(OBJECT_SELF,"TRAVEL_PF",1);
        if (GetLocalInt(OBJECT_SELF,"TRAVEL_HF")==2)  SetLocalInt(OBJECT_SELF,"TRAVEL_HF",1);
        if (GetLocalInt(OBJECT_SELF,"TRAVEL_HFBE")==2) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",1);
        if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTG")==2)  SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",1);
        if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTJ")==2)  SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",1);
        if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==2)   SetLocalInt(OBJECT_SELF,"TRAVEL_LW",1);
        if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==2)   SetLocalInt(OBJECT_SELF,"TRAVEL_CW",1);

        //This switch statement below overrides the variables on the transition to prevent travel to certain
        //locations dependant on the plot state. It sets them to 2 (i.e. allowable but not now). We start by
        //setting all 2s back to 1 (ABOVE) so that all options allowed by the trigger are available, then we
        //switch off the ones we don't want:

        switch (nPlot)
        {
            case 1:
                //Debug line *********************
                //SendMessageToPC(oPC,"I ran the case statement for plot state 1.");
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HFBE")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",2);
                break;
            case 2:
                //Debug line *********************
                //SendMessageToPC(oPC,"I ran the case statement for plot state 2. Polter's should not be available");
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTG")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTJ")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",2);
                // Special line - Barrows entrance only open after Manthia1 dialogue
                if (GetLocalInt(oPC,"nManthiaPlot1")<2 && GetLocalInt(oTrans,"TRAVEL_HFBE")<1 && oTrans!=OBJECT_SELF) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",2);

                break;
            case 3:     //
                //Debug line *********************
                //SendMessageToPC(oPC,"I ran the case statement for plot state 3.");
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTG")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTJ")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HFBE")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",2);
                // Special line - Polter's Fort only open after Hawklin says so
                if (GetLocalInt(oPC,"nPolterOpen")<1 && GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2); // overide as Polter's Fort is not open immediately in this section
                if (GetLocalInt(oPC,"nPolterOpen")<1 && GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2); // overide as Polter's Fort is not open immediately in this section
                break;
            case 4:
                //Debug line *********************
                //SendMessageToPC(oPC,"I ran the case statement for plot state 4.");
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PF",2);
                //if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2);
                if (GetLocalInt(oPC,"nLWOpen")<1 && GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2); // overide as Lake Wyv is not open immediately in this section
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTG")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTJ")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HFBE")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",2);
                break;
            case 5:
                //Debug line *********************
                //SendMessageToPC(oPC,"I ran the case statement for plot state 5.");
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PF",2);
                //if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2);
                //if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTG")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTJ")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HFBE")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",2);
                break;
            case 6:
                //Debug line *********************
                //SendMessageToPC(oPC,"I ran the case statement for plot state 6.");
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PF",2);
                //if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTG")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTJ")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HFBE")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",2);
                break;
            case 7:
                //Debug line *********************
                //SendMessageToPC(oPC,"I ran the case statement for plot state 7.");
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PF",2);
                //if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                //if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTG")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",2);
                //if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTJ")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HFBE")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",2);
                break;
            case 8:
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PFA")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_PF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_PF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_LW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_LW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_CW")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTG")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_TTJ")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HF")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HF",2);
                if (GetLocalInt(OBJECT_SELF,"TRAVEL_HFBE")==1) SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",2);
                break;
/*
            default:  //switch them all on just in case you need to test
                //Debug line *********************
                //SendMessageToPC(oPC,"I ran the default case statement: all available");
                SetLocalInt(OBJECT_SELF,"TRAVEL_PFA",1);
                SetLocalInt(OBJECT_SELF,"TRAVEL_PF",1);
                SetLocalInt(OBJECT_SELF,"TRAVEL_HF",1);
                SetLocalInt(OBJECT_SELF,"TRAVEL_HFBE",1);
                SetLocalInt(OBJECT_SELF,"TRAVEL_TTG",1);
                SetLocalInt(OBJECT_SELF,"TRAVEL_TTJ",1);
                SetLocalInt(OBJECT_SELF,"TRAVEL_LW",1);
                SetLocalInt(OBJECT_SELF,"TRAVEL_CW",2);
                break;
 */
        }
        //AssignCommand(GetClickingObject(),ClearAllActions());
        BeginConversation("Transition",GetClickingObject());
    }
    //ActionStartConversation(OBJECT_SELF,"Transition");
}
