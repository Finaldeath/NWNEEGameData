//Heartbeat script for Kur-Tharsu Gate Ballista

#include "hf_in_plot"
#include "inc_ktgate"

void FireBallista(object oTarget)
{
    int nBallistaSpell = 794;

    float fFacing = 0.0;
    float fNewFacing = 0.0;

    //Face target adjusted by 90 degrees to the right due to placeable facing
    SetFacingPoint(GetPosition(oTarget));
    fFacing = GetFacing(OBJECT_SELF);
    fNewFacing = GetCustomRightDirection(fFacing, 90.0);
    SetFacing(fNewFacing);

    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    if(d8() == 1 && GetLocalInt(OBJECT_SELF, "nAlwaysHit") == 0)
    {
        ActionCastFakeSpellAtLocation(nBallistaSpell,
                                      GetRandomMissLocation(oTarget),
                                      PROJECTILE_PATH_TYPE_HOMING);
    }
    else
    {
        ActionCastSpellAtObject(nBallistaSpell,
                                oTarget,
                                METAMAGIC_ANY,
                                TRUE,
                                15,
                                PROJECTILE_PATH_TYPE_HOMING,
                                TRUE);
    }
}

void main()
{
    object oTarget;

    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 0)
    {
        return;
    }

    oTarget = AcquireTarget(30.0);

    if(oTarget != OBJECT_INVALID)
    {
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        DelayCommand(0.1 * (1 + Random(30)), FireBallista(oTarget));
    }
}
