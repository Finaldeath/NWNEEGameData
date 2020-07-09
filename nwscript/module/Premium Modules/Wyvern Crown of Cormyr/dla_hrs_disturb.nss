//::///////////////////////////////////////////////
//:: dla_hrs_disturb
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

   OnDisturbed event handler for horses

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////


void main()
{
    object oDisturbedBy=GetLastDisturbed();
    if (GetIsPC(oDisturbedBy)) return; // don't want horse to be hostile due to disturbed

    ExecuteScript("nw_ch_ac8", OBJECT_SELF);
}


