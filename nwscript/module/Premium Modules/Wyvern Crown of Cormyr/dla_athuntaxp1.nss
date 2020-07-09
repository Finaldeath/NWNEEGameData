// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC Told huntcrown they will report them. Small alignment xp only (the deed carries more)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "AXP1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    AligXP("AligXP1Hunt", oPC, "LAWFUL", 25, 0);        //Shift/reward any alignment

//    AddJournalQuestEntry("",1,oPC,TRUE);                      //Update the journal
    }

}


