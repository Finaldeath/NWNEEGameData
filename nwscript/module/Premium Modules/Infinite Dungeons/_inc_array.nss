void SetFloatArray(object oObject, string sVarName, int nComponent, float fValue);
float GetFloatArray(object oObject, string sVarName, int nComponent);
// nNumComponents: Number of components in the array. Starts at 0.
// So for an array ranging from 0-63, use 64.
void DeleteFloatArray(object oObject, string sVarName, int nNumComponents);

void SetIntArray(object oObject, string sVarName, int nComponent, int nValue);
int GetIntArray(object oObject, string sVarName, int nComponent);
// nNumComponents: Number of components in the array. Starts at 0.
// So for an array ranging from 0-63, use 64.
void DeleteIntArray(object oObject, string sVarName, int nNumComponents);

void SetLocationArray(object oObject, string sVarName, int nComponent, location lValue);
location GetLocationArray(object oObject, string sVarName, int nComponent);
// nNumComponents: Number of components in the array. Starts at 0.
// So for an array ranging from 0-63, use 64.
void DeleteLocationArray(object oObject, string sVarName, int nNumComponents);

void SetObjectArray(object oObject, string sVarName, int nComponent, object oValue);
object GetObjectArray(object oObject, string sVarName, int nComponent);
// nNumComponents: Number of components in the array. Starts at 0.
// So for an array ranging from 0-63, use 64.
void DeleteObjectArray(object oObject, string sVarName, int nNumComponents);

void SetStringArray(object oObject, string sVarName, int nComponent, string sValue);
string GetStringArray(object oObject, string sVarName, int nComponent);
// nNumComponents: Number of components in the array. Starts at 0.
// So for an array ranging from 0-63, use 64.
void DeleteStringArray(object oObject, string sVarName, int nNumComponents);

/////////////////////////////

void SetFloatArray(object oObject, string sVarName, int nComponent, float fValue)
{
    SetLocalFloat(oObject, sVarName+IntToString(nComponent), fValue);
    return;
}

float GetFloatArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalFloat(oObject, sVarName+IntToString(nComponent));
}

void DeleteFloatArray(object oObject, string sVarName, int nNumComponents)
{
    int x;
    for(x=0;x<nNumComponents;x++) DeleteLocalFloat(oObject, sVarName+IntToString(x));
}

void SetIntArray(object oObject, string sVarName, int nComponent, int nValue)
{
    SetLocalInt(oObject, sVarName+IntToString(nComponent), nValue);
    return;
}

int GetIntArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalInt(oObject, sVarName+IntToString(nComponent));
}

void DeleteIntArray(object oObject, string sVarName, int nNumComponents)
{
    int x;
    for(x=0;x<nNumComponents;x++) DeleteLocalInt(oObject, sVarName+IntToString(x));
}

void SetLocationArray(object oObject, string sVarName, int nComponent, location lValue)
{
    SetLocalLocation(oObject, sVarName+IntToString(nComponent), lValue);
    return;
}

location GetLocationArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalLocation(oObject, sVarName+IntToString(nComponent));
}

void DeleteLocationArray(object oObject, string sVarName, int nNumComponents)
{
    int x;
    for(x=0;x<nNumComponents;x++) DeleteLocalLocation(oObject, sVarName+IntToString(x));
}

void SetObjectArray(object oObject, string sVarName, int nComponent, object oValue)
{
    SetLocalObject(oObject, sVarName+IntToString(nComponent), oValue);
    return;
}

object GetObjectArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalObject(oObject, sVarName+IntToString(nComponent));
}

void DeleteObjectArray(object oObject, string sVarName, int nNumComponents)
{
    int x;
    for(x=0;x<nNumComponents;x++) DeleteLocalObject(oObject, sVarName+IntToString(x));
}

void SetStringArray(object oObject, string sVarName, int nComponent, string sValue)
{
    SetLocalString(oObject, sVarName+IntToString(nComponent), sValue);
    return;
}

string GetStringArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalString(oObject, sVarName+IntToString(nComponent));
}

void DeleteStringArray(object oObject, string sVarName, int nNumComponents)
{
    int x;
    for(x=0;x<nNumComponents;x++) DeleteLocalString(oObject, sVarName+IntToString(x));
}
