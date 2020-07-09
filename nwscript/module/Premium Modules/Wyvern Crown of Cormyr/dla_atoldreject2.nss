//November 2005
// B W-Husey
// Old man runs off, looking for the watch (and is removed from play). Journal reflects attempt to kill old man
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("nDamsel",oPC,11);
    AddJournalQuestEntry("Damsel",43,oPC);
    AssignCommand(OBJECT_SELF,ActionMoveAwayFromObject(oPC,TRUE,100.0));
    AssignCommand(OBJECT_SELF,SpeakOneLinerConversation("watch"));
    DelayCommand(15.0,AssignCommand(OBJECT_SELF,SpeakOneLinerConversation("watch")));
    DestroyObject(OBJECT_SELF,50.0);
    GiveKnightReputation(oPC,"the Cruel");
}
