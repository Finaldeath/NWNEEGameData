//Luspr 15th March 2006
void main()
{
    object oPC=GetEnteringObject();
    if(GetIsPC(oPC)&&GetLocalInt(GetArea(OBJECT_SELF),"entered")<1)
    {
        //set an int to prevent the journal entry being added if
        //pc comes back to area later
        //add starting journal
        //lock the only exit
        SetLocalInt(OBJECT_SELF,"entered",1);
        AddJournalQuestEntry("j35",2,oPC,TRUE);
        object oDoor=GetObjectByTag("metadoor");
        SetLocked(oDoor,TRUE);
    }
}
