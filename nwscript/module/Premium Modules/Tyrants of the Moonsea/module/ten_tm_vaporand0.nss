//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_vaporand0
//:: DATE: January 13, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Vaporandir appears if PC carries dragon eggs
//::////////////////////////////////////////////////////

const string ITM_TAG_DRAGON_EGG = "DragonEgg";

const string NPC_RESREF_VAPORANDIR = "tm_cr_vaporandir";
const string NPC_TAG_VAPORANDIR  = "tm_cr_vaporandir";
const string WP_TAG_VAPORANDIR_SPAWN = "WP_cut_vaporand0_vap_spawn";


int PlayerHasEggs(object oPC)
{
    return (GetIsObjectValid(GetItemPossessedBy(oPC, ITM_TAG_DRAGON_EGG)));
}


object SpawnVaporandir(object oPC)
{
    object oVapo = GetNearestObjectByTag(NPC_TAG_VAPORANDIR, oPC);
    if (!GetIsObjectValid(oVapo))
    {
        object oWaypoint = GetWaypointByTag(WP_TAG_VAPORANDIR_SPAWN);
        oVapo = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_VAPORANDIR, GetLocation(oWaypoint), TRUE, NPC_TAG_VAPORANDIR);
    }
    return oVapo;
}


void main()
{
    object oPC = GetEnteringObject();

    if ((PlayerHasEggs(oPC) && GetLocalInt(OBJECT_SELF, "nDone") <= 0))
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        AssignCommand(oPC, ClearAllActions(TRUE));

        object oVapo = SpawnVaporandir(oPC);
        DelayCommand(1.0f, AssignCommand(oVapo, ActionStartConversation(oPC, "", FALSE, FALSE)));
    }
}
