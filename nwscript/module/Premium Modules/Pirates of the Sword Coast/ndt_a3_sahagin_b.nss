//::///////////////////////////////////////////////
//:: Name ndt_a3_sahagin_b
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Modified OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object oController = GetObjectByTag("a3_controller01");
    int iCounter = GetLocalInt(oController, "iCounter") - 1;
    SetLocalInt(oController, "iCounter", iCounter);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
