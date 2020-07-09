//November 2005
// B W-Husey
// Old man runs off, looking for the watch (and is removed from play). Journal reflects a rejection of quest
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("nDamsel",oPC,10);
    AddJournalQuestEntry("Damsel",51,oPC);
    AssignCommand(OBJECT_SELF,ActionMoveAwayFromObject(oPC,TRUE,100.0));
    DelayCommand(1.0,AssignCommand(OBJECT_SELF,SpeakOneLinerConversation("watch")));
    DelayCommand(15.0,AssignCommand(OBJECT_SELF,SpeakOneLinerConversation("watch")));
    DestroyObject(OBJECT_SELF,30.0);
    GiveKnightReputation(oPC,"the Stern");
}
