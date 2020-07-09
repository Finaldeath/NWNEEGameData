void main()
{
    object oGuard=GetObjectByTag("db_lh_militia");
    object oPC=GetEnteringObject();
    object oWilsey=GetObjectByTag("db_wilsey");
    if(GetLocalInt(GetModule(),"rab_plot")==25&&GetIsPC(oPC))
    {
        AssignCommand(oGuard,SpeakString
        ("Yes Mayor, I clearly saw it enter a fissure in the cliffs."));
        DelayCommand(1.5,AssignCommand(oWilsey,SpeakString
        ("Well, that is interesting. Well done Hegrad.")));
    }
}
