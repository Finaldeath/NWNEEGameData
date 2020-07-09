// February 2006
// B W-Husey
// Sets up which tall story Magurk will tell.

void main()
{
    object oPC = GetPCSpeaker();
    int nStory = GetLocalInt(oPC,"nTallStory");
    string sName;

    if (GetLocalInt(oPC,"nTallDay")!=GetCalendarDay())//Magurk is ready to tell his next story.
    {
        switch(nStory)
        {
        case 1:
            sName = "Var1"+GetTag(OBJECT_SELF);
            SetLocalInt(oPC,sName,TRUE);
        break;
        case 2:
            sName = "Var2"+GetTag(OBJECT_SELF);
            SetLocalInt(oPC,sName,TRUE);
        break;
        case 3:
            sName = "Var3"+GetTag(OBJECT_SELF);
            SetLocalInt(oPC,sName,TRUE);
        break;
        case 4:
            sName = "Var4"+GetTag(OBJECT_SELF);
            SetLocalInt(oPC,sName,TRUE);
        break;
        }
    }
}
