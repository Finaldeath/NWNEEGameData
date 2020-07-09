#include "hf_in_plot"

//::///////////////////////////////////////////////
//:: FileName con_ac_farmer_bk
//:: Callaway walks back to field after Mabda convo
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: January 7, 2006 2:50:30 PM
//:://////////////////////////////////////////////
void main()
{
    object oCallaway = GetObjectByTag("ac_callaway");
    object oCallawayMarkerWP = GetObjectByTag("wp_ac__marker_callaway");
    object oCallawayWP = GetObjectByTag("wp_ac_callaway");

    SetLocalInt(oCallaway,"no_banter",1);

    AssignCommand(oCallaway, ActionMoveToObject(oCallawayMarkerWP, TRUE));
    AssignCommand(oCallaway, ActionMoveToObject(oCallawayWP, TRUE));
    AssignCommand(oCallaway, ActionDoCommand(PlotLevelSet(GetTag(oCallaway),2)));
    AssignCommand(oCallaway, ActionDoCommand(SetLocalInt(oCallaway, "no_banter", 0)));
    AssignCommand(oCallaway, ActionDoCommand(SetLocalInt(oCallaway, "no_hb", 0)));
}
