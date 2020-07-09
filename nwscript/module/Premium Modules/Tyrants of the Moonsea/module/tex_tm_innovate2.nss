//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: tex_tm_innovate
//:: DATE: February 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Innovator conversation: Trigger exit
//:: Checks golem locations and moves them back if
//:: necesary.
//:: Safety in case player cancels dialog before
//:: cac_tm_innovate2 can be executed.
//::////////////////////////////////////////////////////

void MoveBackGolem(object oPC, string sGolemTag, string sGolemWp)
{
    object oGolem = GetNearestObjectByTag(sGolemTag, oPC);
    object oWaypoint = GetNearestObjectByTag(sGolemWp, oPC);
    effect eGhost = EffectCutsceneGhost();

    if (GetDistanceBetween(oGolem, oWaypoint) > 1.0f)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oGolem, 10.0f);
        AssignCommand(oGolem, ActionForceMoveToObject(oWaypoint, FALSE, 0.0f));
        DelayCommand(12.5f, AssignCommand(oGolem, SetFacing (270.0f)));
    }
}

void main()
{
    object oPC = GetEnteringObject();

    MoveBackGolem(oPC, "Left", "WP_Left_Move");
    MoveBackGolem(oPC, "Right", "WP_Right_Move");
}
