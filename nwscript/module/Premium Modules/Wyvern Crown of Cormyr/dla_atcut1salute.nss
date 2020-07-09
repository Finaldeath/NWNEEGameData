// Soldiers salute

void main()
{
    object oEdgar = GetNearestObjectByTag("Edgar");
    object oSoldier1 = GetNearestObjectByTag("PDBCutArrest1");
    object oSoldier2 = GetNearestObjectByTag("PDBCutArrest2");
    AssignCommand(oSoldier1,DelayCommand(1.0,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE)));
    AssignCommand(oSoldier2,DelayCommand(0.4,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE)));
    AssignCommand(oEdgar,DelayCommand(1.1,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE)));
}
