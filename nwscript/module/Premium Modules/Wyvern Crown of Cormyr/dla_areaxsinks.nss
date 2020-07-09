// Jan/Feb 2006
// B W-Husey
// Remove sinking effects from PC, allow sale of helms.

#include "x0_i0_petrify"
#include "cu_functions"

void main()
{

//Gale 17 April 2006: Removing the switch to turn it on/off, since it's handled on hb
//    SetLocalInt(OBJECT_SELF,"nShaker",0);  // Switch off sinking effects & remove effects from player
    object oPC = GetExitingObject();
    object oUnPlot;
    RemoveEffectOfType(oPC,VFX_FNF_SCREEN_SHAKE);
    RemoveEffectOfType(oPC,VFX_FNF_SCREEN_BUMP);
    oUnPlot = GetItemPossessedBy(oPC,"HelmoftheDeep");  //allow sale of helms
    if (GetIsObjectValid(oUnPlot)) SetPlotFlag(oUnPlot,FALSE);
    oUnPlot = GetItemPossessedBy(ReturnHenchman(oPC,1),"HelmoftheDeep");  //allow sale of helms
    if (GetIsObjectValid(oUnPlot)) SetPlotFlag(oUnPlot,FALSE);
    oUnPlot = GetItemPossessedBy(ReturnHenchman(oPC,2),"HelmoftheDeep");  //allow sale of helms
    if (GetIsObjectValid(oUnPlot)) SetPlotFlag(oUnPlot,FALSE);
}
