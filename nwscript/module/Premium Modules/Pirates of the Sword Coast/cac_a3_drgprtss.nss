//::///////////////////////////////////////////////
//:: cac_a3_drgprtss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the Broze dragon has mentioned the
    Priestess of Umberlee.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oDragon = OBJECT_SELF;
    SetLocalInt(oDragon, "cac_a3_drgprtss", TRUE);
}
