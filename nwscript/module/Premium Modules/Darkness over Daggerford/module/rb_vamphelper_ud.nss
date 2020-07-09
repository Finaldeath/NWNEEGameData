#include "x0_i0_petrify"

void main()
{
    effect eBoom=EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE );
    effect eTransform=EffectVisualEffect(VFX_IMP_HEALING_X);
    effect eSoulsuck=EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES);
    effect eVanish = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);

    object oGas1;
    object oGas2;
    object oLula;
    object oPC=GetFirstPC();
    object oXanda=GetObjectByTag("db_xanda_unc2");
    object oXanda2=GetObjectByTag("db_xanda_living"); //original Xanda
    object oVampire=GetObjectByTag("db_vampire");

    location lVamp1;
    location lVamp2;

    string sGas1=("db_sieronius_gas");
    string sGas2=("db_lula_gas");

    switch(GetUserDefinedEventNumber())
    {
        //Xanda has been left for the vampire to marry
        case 5000:
            //rab's plot ended by leaving the vampire with xanda
            SetLocalInt(GetModule(),"rab_plot",40);
            SetLocalInt(GetModule(),"lula_met",4);

            //In case there is still a Xanda in her house, destroy her.
            //This would be the case if player hasn't gone into Xanda's house
            //after guard/mayor mini-cutscene (see oe_ar1306)
            if(GetIsObjectValid(oXanda2))
            {
                DestroyObject(oXanda2,1.0);
            }

            AssignCommand(oXanda, SetIsDestroyable(TRUE));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eSoulsuck,GetLocation(oXanda));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVanish,GetLocation(oVampire));
            DestroyObject(oVampire,0.2);

            DestroyObject(oXanda,0.4);
        break;

        //the 2 vampires Sieronius and Lula assume their gaseous form and leave
        case 5001:

        //set the plot level - vampire wedding
        SetLocalInt(GetModule(),"rab_plot",45);
        oLula = GetObjectByTag("db_lula");
        lVamp1=GetLocation(oVampire);
        lVamp2=GetLocation(oLula);

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTransform,lVamp1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTransform,lVamp2);
        //and destroy the vampires
        DestroyObject(oVampire,0.5);
        DestroyObject(oLula,0.5);

        //create the gas and 'boom' them
        sGas1=("db_sieronius_gas");
        sGas2=("db_lula_gas");
        oGas1=CreateObject(OBJECT_TYPE_CREATURE,sGas1,lVamp1);
        oGas2=CreateObject(OBJECT_TYPE_CREATURE,sGas2,lVamp2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eBoom,oGas1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eBoom,oGas2);

        //deal with Xanda
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(),oXanda);
        AssignCommand(oXanda, SetIsDestroyable(TRUE));

        //in case there is still a Xanda in her house, destroy her
        if(GetIsObjectValid(oXanda2))
        {
            DestroyObject(oXanda2,1.0);
        }
        AssignCommand(oPC,ClearAllActions(TRUE));
        //hopefully one of these will fire!
        DelayCommand(1.5,AssignCommand(oXanda,ActionStartConversation(oPC)));
        DelayCommand(1.5,AssignCommand(oPC,ActionStartConversation(oXanda)));

        break;

        //Vampire on death
        case 5002:

        SetLocalInt(GetModule(),"rab_plot",50);
        SetLocalInt(GetModule(),"lula_met",4);
        AddJournalQuestEntry("j31",12,oPC);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(),oXanda);
        AssignCommand(oXanda, SetIsDestroyable(TRUE));

        //in case there is still a Xanda in her house, destroy her
        if(GetIsObjectValid(oXanda2))
        {
            DestroyObject(oXanda2,1.0);
        }

        AssignCommand(oPC,ClearAllActions(TRUE));
        //hopefully one of these will fire!
        DelayCommand(1.5,AssignCommand(oXanda,ActionStartConversation(oPC)));
        DelayCommand(1.5,AssignCommand(oPC,ActionStartConversation(oXanda)));
        break;
    }
 }
