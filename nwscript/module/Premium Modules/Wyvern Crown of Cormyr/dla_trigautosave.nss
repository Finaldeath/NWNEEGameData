#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
    AssignCommand(oPC,DelayCommand(0.3,DoSinglePlayerAutoSave()));
    DestroyObject(OBJECT_SELF);
    }
}
