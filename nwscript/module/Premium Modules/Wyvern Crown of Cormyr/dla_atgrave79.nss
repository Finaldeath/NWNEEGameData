// March 2006
// B W-Husey
// Set the nGrave variable to reflect that reparations have been extracted from the bad knight.
// 7 = reparations only, 9 = completed (i.e. got a new grave too)
// Alignment consequences - everyone does ok (but lawful would do better by reporting it)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "grave79"+GetTag(OBJECT_SELF);                     //Unique tag
int nGrave = GetLocalInt(oPC,"nGrave");
//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action (doing what you should points in this case!)
    AligXP("AligGFix3", oPC, "CHAOTIC", 50, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
        if (nGrave == 6)     //PC already ordered a grave
        {
            AllParty("nGrave",oPC,9);                                    //Quest completed
            PartyGotEntry(sName,oPC,500,"XP Gain - father rests peacefully");  //This comes with XP & message + sets the variable
        }
        else if (nGrave == 5) //PC has not ordered a grave and also needs to do that
        {
            AllParty("nGrave",oPC,7);
            PartyGotEntry(sName,oPC,100,"XP Gain - father rests easier");        //Just sets variable
        }
        ScoreAlign(oPC,4,3,4,4,3,4,4,3,4,4);            //Who gets alignment points for this
    }

}


