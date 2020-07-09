// March 2006
// B W-Husey
// Godfroy faces East

void main()
{
    object oGod = GetNearestObjectByTag("Godfroy");
    DelayCommand(0.1,AssignCommand(oGod,SetFacing(0.0)));
    DelayCommand(0.2,AssignCommand(oGod,ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0,5.0)));

}
