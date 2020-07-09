// January 2006
// B W-Husey
// Triggers the cutscene with Wyvernvapor. Also sets the nPiracy variable depending
// on whether the ship escaped or not.

#include "cu_functions"
#include "cu_cutscenes"
#include "cu_cameras"

void main()
{
    object oPC = GetEnteringObject();
    float fDelay=0.0;
    if (GetIsDefPC(oPC))
    {
        SetCutsceneMode(oPC,TRUE);
         FadeToBlack(oPC);
        WCCameraMove(0.0,130.0,10.0,70.0,130.0,10.0,70.0,0.1,1.0,oPC);   // get camera to right starting position

        int nPirate = GetLocalInt(oPC,"nPiracy"); //needed to pdate the journal and give alignment consequences
        // for the piracy side quest.

        if (nPirate == 5) //PC struck a deal, not a very good person!
        {
            AllParty("nPiracy",oPC,8);    //Just sets variable
            AddJournalQuestEntry("Piracy",51,oPC,TRUE);                      //Update the journal
            ScoreAlign(oPC,5,0,0,0,1,4,5,3,5,5);            //Who gets alignment points for this
        }
        else if (nPirate == 4 || nPirate == 6) //PC killed Salvatori and/or sank his ship, good and lawful option
        {
            AllParty("nPiracy",oPC,7);    //Just sets variable
            AddJournalQuestEntry("Piracy",50,oPC,TRUE);                      //Update the journal
            ScoreAlign(oPC,5,5,5,5,5,5,1,5,3,1);            //Who gets alignment points for this
        }
        else //We can assume the pirate ship is still in the castle but sinking was incidental. No alignment issues
        {
            AllParty("nPiracy",oPC,7);    //Just sets variable
            AddJournalQuestEntry("Piracy",50,oPC,TRUE);                      //Update the journal
            ScoreAlign(oPC,5,5,5,5,5,5,5,5,5,5);            //Who gets alignment points for this
        }
        DelayCommand(fDelay+=0.1,FadeFromBlack(oPC));
        ClearForCut(oPC);
        DelayCommand(fDelay+=1.1,ExecuteScript("dla_cutdragon",oPC));
        DestroyObject(OBJECT_SELF,1.5);
    }
}
