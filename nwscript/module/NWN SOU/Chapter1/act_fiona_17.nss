//::///////////////////////////////////////////////
//:: Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Give PC magic boots and take promissary note.
*/
//:://////////////////////////////////////////////
//:: Created By: Dan Whiteside
//:: Created On: March 17, 2003
//:://////////////////////////////////////////////
void main()
{
    CreateItemOnObject("nw_it_mboots012",GetPCSpeaker());
    DestroyObject(GetObjectByTag("q3_promissary"));
}