//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: nsp_tm_deaddra
//:: DATE: December 28, 2018
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Kills self, clean inventory based on quest status
//::
//::////////////////////////////////////////////////////

#include "hf_in_plot"


const string ITM_TAG_FAKE_TONGUE = "tm_it_vaptongue1";


// Remove Dragon tongue if quest status is not set
void CheckDragonTongue(object oTarget)
{
    object oTongue = GetItemPossessedBy(oTarget, ITM_TAG_FAKE_TONGUE);
    if ( GetIsObjectValid(oTongue) && (PlotLevelGet("biggamehunt_status_vapo") < 1) )
    {
        DestroyObject(oTongue);
    }
}


void main()
{
    ExecuteScript("nw_c2_default9", OBJECT_SELF);

    CheckDragonTongue(OBJECT_SELF);

    SetIsDestroyable(FALSE, FALSE, TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDeath(), OBJECT_SELF, 0.0);
}
