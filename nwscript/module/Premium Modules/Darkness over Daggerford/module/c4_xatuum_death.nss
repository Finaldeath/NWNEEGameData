//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    SignalEvent(GetObjectByTag("rb_xatuum_helper"), EventUserDefined(6000));

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
