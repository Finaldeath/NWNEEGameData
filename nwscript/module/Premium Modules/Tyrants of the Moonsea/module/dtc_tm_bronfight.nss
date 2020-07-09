//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: dtc_tm_bronfight
//::////////////////////////////////////////////////////
//:: Voonlar: The Swords Meet - Door transition
//:: Send the player to the Bron fight WP insted of the
//:: default transitiontarget when conditions are met.
//::////////////////////////////////////////////////////

const string WP_TAG_BRONFIGHT_PC_INIT = "WP_bronfight_pc_init";

const string LVAR_BRONFIGHT_DOONCE = "bronfight_once";


int CheckJumpToBronfight(object oDoor, object oPC)
{
    int nJournal = GetLocalInt(oPC, "NW_JOURNAL_ENTRYVoonlar");
    int nDoOnce = GetLocalInt(oDoor, LVAR_BRONFIGHT_DOONCE);
    return ( (nJournal >= 20) && (nDoOnce == 0) );
}


void main()
{
    object oPC = GetClickingObject();
    object oTransitionTarget = GetTransitionTarget(OBJECT_SELF);

    if (CheckJumpToBronfight(OBJECT_SELF, oPC))
    {
        SetLocalInt(OBJECT_SELF, LVAR_BRONFIGHT_DOONCE, 1);
        oTransitionTarget = GetWaypointByTag(WP_TAG_BRONFIGHT_PC_INIT);
        DoSinglePlayerAutoSave();
    }
    AssignCommand(oPC, JumpToObject(oTransitionTarget));
}
