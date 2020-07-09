void main()
{
    //the 2 vampires Sieronius and Lula assume their gaseous form
    //and leave forever
    SignalEvent(GetObjectByTag("rb_vamp_helper"),EventUserDefined(5001));

    //set the plot level - vampire wedding
    //SetLocalInt(GetModule(),"rab_plot",45);
    //object oSieronius=GetObjectByTag("db_vampire");
    //object oLula=GetObjectByTag("db_lula");
    //effect eTransform=EffectVisualEffect(VFX_IMP_HEALING_X);
    //location lVamp1=GetLocation(oSieronius);
    //location lVamp2=GetLocation(oLula);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,eTransform,oSieronius);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,eTransform,oLula);
    //and destroy the vampires
    //DestroyObject(oSieronius,0.5);
    //DestroyObject(oLula,0.5);
    //create the gas and 'boom' them
    //string sGas1=("db_sieronius_gas");
    //string sGas2=("db_lula_gas");
    //object oGas1=CreateObject(OBJECT_TYPE_CREATURE,sGas1,lVamp1);
    //object oGas2=CreateObject(OBJECT_TYPE_CREATURE,sGas2,lVamp2);
    //effect eBoom=EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE );
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,eBoom,oGas1);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,eBoom,oGas2);
    //object oXanda=GetObjectByTag("db_xanda_unc2");
    //SetPlotFlag(oXanda, FALSE);
    //object oPC=GetFirstPC();
    //effect eZonked=GetFirstEffect(oXanda);
    //while (GetIsEffectValid(eZonked))
      //  {
      //  if (GetEffectType(eZonked)==EFFECT_TYPE_SLEEP)
      //  RemoveEffect(oXanda,eZonked);
      //  eZonked=GetNextEffect(oXanda);
      //  }
    //in case there is still a Xanda in her house
    //destroy her
    //object oXanda2=GetObjectByTag("db_xanda_living");
    //if(GetIsObjectValid(oXanda2))
    //{
      //  DestroyObject(oXanda2,1.0);
   // }
   // AssignCommand(oPC,ClearAllActions());
    //hopefully one of these will fire!
   // DelayCommand(1.5,AssignCommand(oXanda,ActionStartConversation(oPC)));
   // DelayCommand(1.5,AssignCommand(oPC,ActionStartConversation(oXanda)));
}
