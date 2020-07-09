
void main()
{
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
    //SCRAP ALL THIS BIT IN CASE OF 3RD PARTY DAMAGE
    //set the int even if the players hench or summons killed creature
    //object oPC = GetLastKiller();
    //while(GetIsObjectValid(GetMaster(oPC)))
    //{
        //oPC=GetMaster(oPC);
    //}
    //if (!GetIsPC(oPC)) return;

    //new oPC definition (1st August 2006)
    object oPC = GetFirstPC();

    int nInt;
    nInt = GetLocalInt(GetModule(),"hom_creatures_killed");
    nInt += 1;
    SetLocalInt(GetModule(),"hom_creatures_killed",nInt);
    if(GetLocalInt(GetModule(),"hom_creatures_killed")==12)
    {
        SetLocalInt(GetModule(),"meta_quest",2);
        AddJournalQuestEntry("j35",6,oPC);
        object oMeta=GetObjectByTag("db_sending");
        //effect eZonked=ExtraordinaryEffect(EffectSleep());
        //let's try it with death instead
        SetPlotFlag(oMeta,FALSE);
        effect eZonked=ExtraordinaryEffect(EffectDeath(TRUE));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eZonked,oMeta);
        effect eMetakill=EffectVisualEffect(VFX_FNF_IMPLOSION);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eMetakill,oMeta);
    }
}
