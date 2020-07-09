//::///////////////////////////////////////////////
//:: cut_a1watchfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This special cutscene script allows the players
    not competein in the arena with Garm to watch
    the fight or jump back to the cell and wait
    their turn
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    object oArea = OBJECT_SELF;
    object oFighterStart = GetWaypointByTag("a1_fghtsrt03");
    object oGarm = GetObjectByTag("a1_garmclone");
    object oPC = GetFirstPC();
    object oFighter = GetLocalObject(oArea, "A1_CURRFIGHTER");
    object oCamera = GetWaypointByTag("a1_fightcam");
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    while(GetIsObjectValid(oPC) == TRUE)
    {
        if (oPC != oFighter)
        {
            ExecuteScript("exe_a1watchfight", oPC);
            DelayCommand(0.5f, AdjustReputation(oPC, oGarm, 75));
        }
        else
        {
            AssignCommand(oPC, JumpToLocation(GetLocation(oFighterStart)));
            AssignCommand(oPC, SetFacingPoint(GetPosition(oGarm)));
            AssignCommand(oPC, SetCameraFacing(90.0f, 12.0f, 60.0f));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, 1),
                JumpToLocation(GetLocation(oFighterStart)));
            AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, 1),
                JumpToLocation(GetLocation(oFighterStart)));
            AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, 1),
                JumpToLocation(GetLocation(oFighterStart)));

            ChangeToStandardFaction(oGarm, STANDARD_FACTION_HOSTILE);
            DelayCommand(1.0f, AssignCommand(oGarm, ActionAttack(oFighter)));
        }

        oPC = GetNextPC();
    }
}
