//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:: Additions bt Damian Brown (15th Oct 2005)
//:://////////////////////////////////////////////
#include "nw_i0_plot"
void main()
{
    SignalEvent(GetObjectByTag("rb_vamp_helper"),EventUserDefined(5002));
    //set the plot int: vampire has been killed
    //SetLocalInt(GetModule(),"rab_plot",50);
    //SetLocalInt(GetModule(),"lula_met",4);
    //AddJournalQuestEntry("j31",12,GetLastKiller());
    //object oXanda=GetObjectByTag("db_xanda_unc2");
    //SetPlotFlag(oXanda, FALSE);
    //object oPC=GetNearestPC();
    //effect eZonked=GetFirstEffect(oXanda);
    //while (GetIsEffectValid(eZonked))
    //    {
    //    if (GetEffectType(eZonked)==EFFECT_TYPE_SLEEP)
    //    RemoveEffect(oXanda,eZonked);
     //   eZonked=GetNextEffect(oXanda);
    //    }
    //in case there is still a Xanda in her house
    //destroy her
    //object oXanda2=GetObjectByTag("db_xanda_living");
    //if(GetIsObjectValid(oXanda2))
    //{
    //    DestroyObject(oXanda2,1.0);
    //}
   // AssignCommand(oPC,ClearAllActions());
    //hopefully one of these will fire!
    //DelayCommand(1.5,AssignCommand(oXanda,ActionStartConversation(oPC)));
    //DelayCommand(1.5,AssignCommand(oPC,ActionStartConversation(oXanda)));
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
