// January 2006
// B W-Husey
// PC gives Wyvernvapor the ball for free.

#include "cu_functions"
//#include "nw_i0_tool"

void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j59"+GetTag(OBJECT_SELF);                     //Unique tag

    // Remove from the player
       object oBall = GetObjectByTag("CrystalBall");
       SetPlotFlag(oBall,FALSE);
       DestroyObject(oBall);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    AligXP("AligXP1wj59", oPC, "CHAOTIC", 0, 1);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty("nMyth",oPC,3);                                    //Mythallar variable set to ball returned
    PartyGotEntry(sName,oPC,100,"XP Gain - Ball returned");
    AddJournalQuestEntry("Mythallar",59,oPC,TRUE);             //Update the journal
    //Bonus just for this action
    ScoreAlign(oPC,1,1,1,1,1,1,1,0,0,0);            //Who gets alignment points for this
    }

    if (HasItem(GetPCSpeaker(),"CrystalBall")) //double check
    {
       SetPlotFlag(oBall,FALSE);
       DestroyObject(oBall);
    }

}





