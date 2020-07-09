void main()
{
    object oPC=GetEnteringObject();
    //Meta is dead but we still want her to speak
    //this uses the invis object replacement Meta
    //is Meta dead but still speaking?
    if(GetLocalInt(GetModule(),"meta_quest")==2)
    {
        object oMeta = GetObjectByTag("db_meta_io");
        //pc will probably still be in combat mode, cancel it
        AssignCommand(oPC, ClearAllActions(TRUE));

        //prevent the saftey routine from running if the death events worked
        SetLocalInt(GetModule(),"hom_globes_activated", 5);

        DelayCommand(0.2, AssignCommand(oMeta, ActionStartConversation(oPC)));
    }
    else
    {
        //this is where the security check goes
        object oFrag1 = GetObjectByTag("db_fragment_rev1");
        object oFrag2 = GetObjectByTag("db_fragment_rev2");
        object oFrag3 = GetObjectByTag("db_fragment_rev3");
        object oFrag4 = GetObjectByTag("db_fragment_rev4");
        object oFrag5 = GetObjectByTag("db_fragment_rev5");
        object oFrag6 = GetObjectByTag("db_fragment_rev6");
        //has player pressed all devices?
        if(GetLocalInt(GetModule(),"hom_globes_activated") ==4 &&

        //are there no shadows in the area?
        GetIsObjectValid(oFrag1) == FALSE &&
        GetIsObjectValid(oFrag2) == FALSE &&
        GetIsObjectValid(oFrag3) == FALSE &&
        GetIsObjectValid(oFrag4) == FALSE &&
        GetIsObjectValid(oFrag5) == FALSE &&
        GetIsObjectValid(oFrag6) == FALSE)
        {
            //set the int for Meta's conversation
            SetLocalInt(GetModule(),"meta_quest", 2);

            //pc will probably still be in combat mode, cancel it
            AssignCommand(oPC, ClearAllActions(TRUE));

            //kill Metastakixx
            AddJournalQuestEntry("j35",6,oPC);
            object oMeta=GetObjectByTag("db_sending");
            //effect eZonked=ExtraordinaryEffect(EffectSleep());
            //let's try it with death instead
            SetPlotFlag(oMeta,FALSE);
            effect eZonked=ExtraordinaryEffect(EffectDeath(TRUE));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eZonked,oMeta);
            effect eMetakill=EffectVisualEffect(VFX_FNF_IMPLOSION);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eMetakill,oMeta);

            //prevent the saftey routine from running more than once
            SetLocalInt(GetModule(),"hom_globes_activated", 5);

            //now that Meta is dead, use the invisible Meta to talk to the player
            //delay increased to give effect time to fire
            //probably going to look slightly weird as the player pauses for nearly a second
            //but better than getting stuck in the house of mists for eternity!
            //(just ask Meta...)
            object oMeta2 = GetObjectByTag("db_meta_io");
            DelayCommand(0.8, AssignCommand(oMeta2, ActionStartConversation(oPC)));//metacode
        }

    }
}
