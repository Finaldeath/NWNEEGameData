//::///////////////////////////////////////////////
//:: Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
        Give PC Rifkin's gift and set local.
*/
//:://////////////////////////////////////////////
//:: Created By: Dan Whiteside
//:: Created On: April 9, 2003
//:://////////////////////////////////////////////
void main()
{
    CreateItemOnObject("NW_IT_MNECK013",GetPCSpeaker());
    SetLocalInt(GetPCSpeaker(),"X1_RIFKINGIFT",10);
}
