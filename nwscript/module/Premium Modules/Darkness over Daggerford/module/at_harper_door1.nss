//destroy the door, spawn in harpers and turn them hostile
#include "nw_i0_generic"
void main()
{
    object oDoor = GetObjectByTag("harper_door");
    object oPC = GetPCSpeaker();

    // make sure we don't create two copies of the harpers
    object oDrelia = GetObjectByTag("db_drelia");
    if (GetIsObjectValid(oDrelia))
        DestroyObject(oDrelia);
    object oBrenda = GetObjectByTag("db_brenda");
    if (GetIsObjectValid(oBrenda))
        DestroyObject(oBrenda);
    object oMeyhew = GetObjectByTag("db_meyhew");
    if (GetIsObjectValid(oMeyhew))
        DestroyObject(oMeyhew);

    location lDrelia = GetLocation(GetWaypointByTag("wp_drelia2"));
    location lBrenda = GetLocation(GetWaypointByTag("wp_brenda"));
    location lMeyhew = GetLocation(GetWaypointByTag("wp_meyhew2"));
    //create the harpers
    oDrelia = CreateObject(OBJECT_TYPE_CREATURE,"db_drelia",lDrelia);
    oBrenda = CreateObject(OBJECT_TYPE_CREATURE,"db_brenda",lBrenda);
    oMeyhew = CreateObject(OBJECT_TYPE_CREATURE,"db_meyhew",lMeyhew);
    //make them hostile to the player
    DelayCommand(0.5, ChangeToStandardFaction(oDrelia,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.5, ChangeToStandardFaction(oBrenda,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.5, ChangeToStandardFaction(oMeyhew,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.9, AssignCommand(oDrelia, DetermineCombatRound(oPC)));
    DelayCommand(0.9, AssignCommand(oBrenda, DetermineCombatRound(oPC)));
    DelayCommand(0.9, AssignCommand(oMeyhew, DetermineCombatRound(oPC)));
    //destroy the door
    SetPlotFlag(oDoor,FALSE);
    effect eDamage = EffectDamage(400,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL);
    DelayCommand(0.8,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oDoor));
    //the PC bursts through the door
    DelayCommand(0.8,AssignCommand(oPC,ClearAllActions()));
    DelayCommand(0.9,AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("wp_breakdowndoor"))));
}
