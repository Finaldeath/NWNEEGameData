//::///////////////////////////////////////////////
//:: M3Q3D_SUCCFREE
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets a local so you know the succubus is free
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void main()
{
    SetLocalInt(OBJECT_SELF,"NW_G_SUCCUBUS_FREE",1);
    SpeakString("Free");
}