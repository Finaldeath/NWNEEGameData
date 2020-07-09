//::///////////////////////////////////////////////
//:: Default: On User Defined
//:: NW_C2_DEFAULTD
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////
void main()
{
    // enter desired behaviour here

    int nEvent = GetUserDefinedEventNumber();

    if ((nEvent == EVENT_ATTACKED)
     || (nEvent == EVENT_END_COMBAT_ROUND)
     || (nEvent == EVENT_SPELL_CAST_AT)) // attacked or end combat round or spell cast at
    {
        object oAttacker = GetLastHostileActor();
        if (GetIsObjectValid(oAttacker))
        {
            if (GetCurrentHitPoints() > 0)
            {
                if (GetLocalInt(OBJECT_SELF, "nPorted") == 0)
                {
                    ClearAllActions();

                    effect eVanish = EffectVisualEffect(VFX_IMP_UNSUMMON);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVanish, OBJECT_SELF);

                    DestroyObject(OBJECT_SELF, 0.6);

                    SetLocalInt(OBJECT_SELF, "nPorted", 1);
                }
            }
        }
    }

    return;
}
