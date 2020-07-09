// March 2006
// B W-Husey
// Speaker faces East, so does PC.

void main()
{
    object oMe = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    DelayCommand(0.1,AssignCommand(oMe,SetFacing(0.0)));
    DelayCommand(0.2,AssignCommand(oMe,ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0,2.0)));
    DelayCommand(0.3,AssignCommand(oPC,SetFacing(0.0)));
    DelayCommand(0.7,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0,2.0)));
}
