//Luspr 15th March 2006
void main()
{
    object oPC=GetExitingObject();
    if(GetIsPC(oPC)&&GetLocalInt(OBJECT_SELF,"entered")!=2)
    {
        if(GetLocalInt(oPC, "meta_end_bard")==1)
        {
            //Increase the area int
            SetLocalInt(OBJECT_SELF,"entered",2);
            //give the bard ending
            AddJournalQuestEntry("j35", 9, oPC);
        }
        else
        {
            //Increase the area int
            SetLocalInt(OBJECT_SELF,"entered",2);
            //give the non bard ending
            AddJournalQuestEntry("j35", 10, oPC);
        }
    }
}
