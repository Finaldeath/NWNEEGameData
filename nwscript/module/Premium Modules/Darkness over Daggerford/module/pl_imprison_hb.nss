void Vfx(object o)
{
    location lLoc = GetLocation(o);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), lLoc);
}

void AreaControlLoop()
{
    object oArea = GetArea(OBJECT_SELF);
    if (GetLocalInt(oArea, "nSceneEnded") != 0)
    {
        object oHench = GetLocalObject(oArea, "oHenchman");
        if (GetArea(oHench) == GetArea(OBJECT_SELF))
        {
            if (GetMaster(oHench) == OBJECT_INVALID)
            {
                if (!IsInConversation(oHench) && !GetIsInCombat(oHench))
                {
                    // heal self after combat
                    if (GetLocalInt(OBJECT_SELF, "nDrunkPotion") == 0)
                    {
                        SetLocalInt(OBJECT_SELF, "nDrunkPotion", 1);
                        AssignCommand(oHench, ClearAllActions());
                        AssignCommand(oHench, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(50), oHench);
                    }

                    // masterless henchies should walk back to the wagons
                    object oWP = GetNearestObjectByTag("WP_AR0600_HENCHMAN", OBJECT_SELF);
                    if (GetDistanceBetween(oWP, oHench) >= 2.0)
                    {
                        int nCount = GetLocalInt(oArea, "nHenchmanMoveCounter");
                        if (nCount >= 3)
                        {
                            SetLocalInt(oArea, "nHenchmanMoveCounter", 0);
                            AssignCommand(oHench, ClearAllActions());
                            AssignCommand(oHench, JumpToObject(oWP));
                        }
                        else
                        {
                            AssignCommand(oHench, ActionMoveToObject(oWP, TRUE));
                            SetLocalInt(oArea, "nHenchmanMoveCounter", ++nCount);
                        }
                    }
                }
            }
        }
    }
}

void main()
{
    DelayCommand(0.0, Vfx(OBJECT_SELF));
    DelayCommand(3.0, Vfx(OBJECT_SELF));
    AreaControlLoop();
}
