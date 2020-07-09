#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(GetModule(), "iDestroyHarpers") == 1)
    {
        SetLocalInt(GetModule(), "iDestroyHarpers", 2);
        //despawn the harpers from the inn
        object oDrelia = GetObjectInArea("db_drelia", oPC);
        object oBrenda = GetObjectInArea("db_brenda", oPC);
        object oMeyhew = GetObjectInArea("db_meyhew", oPC);
        DelayCommand(0.5,DestroyObject(oDrelia));
        DelayCommand(0.5,DestroyObject(oBrenda));
        DelayCommand(0.5,DestroyObject(oMeyhew));
    }
}
