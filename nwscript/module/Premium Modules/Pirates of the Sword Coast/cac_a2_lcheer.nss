//::///////////////////////////////////////////////
//:: cac_a2_lcheer
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Everyone around Langer cheers!
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

void main()
{
    object oLanger = OBJECT_SELF;
    object oArea = GetArea(oLanger);
    object oCursor = GetFirstObjectInArea(oArea);

    // All of the object that can cheer, should cheer for langer.
    while(GetIsObjectValid(oCursor) == TRUE)
    {
        if ((GetObjectType(oCursor) == OBJECT_TYPE_CREATURE)
            && (oCursor != oLanger) && (GetIsPC(oCursor) == FALSE))
        {
            DelayCommand(2.0f, AssignCommand(oCursor,
                PlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
            DelayCommand(2.0f, AssignCommand(oCursor,
                PlayVoiceChat(VOICE_CHAT_CHEER, oCursor)));
        }

        oCursor = GetNextObjectInArea(oArea);
    }
}
