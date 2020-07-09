//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_sylargang
//:: DATE: December 29, 2018
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Old Jeffers appears after defeating Sylars Gang
//::////////////////////////////////////////////////////

const string NPC_RESREF_JEFFERS = "oldjeffers";
const string NPC_TAG_JEFFERS = "OldJeffers";
const string WP_TAG_JEFFERS_SPAWN = "WP_cut_sylar_jeff_spawn";

const string LVAR_NUM_GANG_MEMBERS = "cut_sylar_thug_cnt";
const int NUM_GANG_MEMBERS = 4;

void startJeffersDialog(object oJeffers, object oPC)
{
    AssignCommand(oPC, ClearAllActions(TRUE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 5.2);

    AssignCommand(oJeffers, ClearAllActions(TRUE));
    AssignCommand(oJeffers, ActionStartConversation(oPC, "", FALSE, FALSE));
}


void postFightSetup(object oPC)
{
    object oJeffers = GetObjectByTag(NPC_TAG_JEFFERS);
    object oWaypoint = OBJECT_INVALID;
    if (!GetIsObjectValid(oJeffers))
    {
        oWaypoint = GetNearestObjectByTag(WP_TAG_JEFFERS_SPAWN, oPC);
        oJeffers = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_JEFFERS, GetLocation(oWaypoint), FALSE, NPC_TAG_JEFFERS);

        DelayCommand(4.0f, startJeffersDialog(oJeffers, oPC));
    }
}


void main()
{
    object oPC = GetFirstPC();

    int nDeadGangMembers = GetLocalInt(oPC, LVAR_NUM_GANG_MEMBERS)+1;
    SetLocalInt(oPC, LVAR_NUM_GANG_MEMBERS, nDeadGangMembers);

    if (nDeadGangMembers >= NUM_GANG_MEMBERS)
    {
        postFightSetup(oPC);
        DeleteLocalInt(oPC, LVAR_NUM_GANG_MEMBERS);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
