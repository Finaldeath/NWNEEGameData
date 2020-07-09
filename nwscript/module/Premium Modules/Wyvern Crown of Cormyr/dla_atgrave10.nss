// April 2006
// B W-Husey
// NPC rewards template to be used after an action
// Knight murdered - not a good thing to do!

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nKMurder"+GetTag(OBJECT_SELF);                     //Unique tag
object oKnight = GetObjectByTag("BadKnight");
//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // Remove from the player
    TakeGoldFromCreature(1000, GetPCSpeaker(), FALSE);
    AssignCommand(oKnight,SetIsDestroyable(TRUE,FALSE));
    SetPlotFlag(oKnight, FALSE);
    SetImmortal(oKnight,FALSE);
    DestroyObject(oKnight,1.0);
    //Alignment consequences of action
    AligXP("AligAXP1Murder", oPC, "EVIL", 250, 5);        //Shift/reward any alignment
    AligXP("AligAXP2Murder", oPC, "CHAOTIC", 0, 3);        //Shift/reward any alignment

    //Set variable for PC or partywide
        AllParty("nGrave",oPC,10);
        AddJournalQuestEntry("Grave",95,oPC,TRUE);                      //Update the journal
        ScoreAlign(oPC,1,0,0,0,0,1,1,1,1,1);            //Who gets alignment points for this
    }

}


