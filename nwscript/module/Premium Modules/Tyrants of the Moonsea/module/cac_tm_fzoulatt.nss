//Player rejects Fzoul offer and challenges to combat
//Can be initiated from Maganus or Fzoul dialog

#include "nw_i0_generic"

#include "hf_in_friend"
#include "hf_in_plot"

void TurnFzoulAllyHostile(object oCreature)
{
    object oPC = GetFirstPC();

    SetPlotFlag(oCreature, FALSE);
    ChangeToStandardFaction(oCreature, STANDARD_FACTION_HOSTILE);
    AssignCommand(oCreature, DetermineCombatRound(oPC));
}

void main()
{
    object oPC = GetPCSpeaker();

    object oArea = GetArea(oPC);
    object oFzoul = GetNearestObjectByTag("Fzoul", oPC);;
    object oGuard;
    object oMaganus = GetNearestObjectByTag("StrongholdMaganus", oPC);
    object oScyllua = GetNearestObjectByTag("Scyllua", oPC);

    PlotLevelSet("Fzoul", 6);

    //Maganus gets out of the way
    AssignCommand(oMaganus,
        ActionForceMoveToObject(GetWaypointByTag("WP_ZKTEM_CS_MAGANUS_MOVE"), TRUE, 1.0, 10.0));
    AssignCommand(oMaganus, ActionDoCommand(SetFacing(DIRECTION_SOUTH)));

    //Fzoul and temple guards attack
    TurnFzoulAllyHostile(oFzoul);
    FriendSetMaster(oFzoul, oScyllua);
    TurnFzoulAllyHostile(oScyllua);

    oArea = GetArea(oFzoul);

    oGuard = GetFirstObjectInArea(oArea);
    while(oGuard != OBJECT_INVALID)
    {
        if(GetTag(oGuard) == "FzoulGuard" &&
           GetObjectType(oGuard) == OBJECT_TYPE_CREATURE &&
           !GetIsDead(oGuard))
        {
            TurnFzoulAllyHostile(oGuard);
        }
        oGuard = GetNextObjectInArea(oArea);
    }
}
