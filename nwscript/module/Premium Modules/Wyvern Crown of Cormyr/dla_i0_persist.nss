//::///////////////////////////////////////////////
//:: dla_i0_horse
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Include file of DLA Horse system.
   Includes all functions that handle data persistency
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: June 9, 2005
//:://////////////////////////////////////////////


// Returns the unique PC's ID; character name, and PLAYER ID strings put
// together. Used by the DLA_GetPersist, DLA_SetPersist series of functions
string DLA_GetID(object oPC);

// Retrieve the integer stored persistently using DLA_SetPersistentInt
// The integer is associated with oPC and stored in the variable sVar
int DLA_GetPersistInt(object oPC, string sVar);

// Retrieve the float stored persistently using DLA_SetPersistentFloat
// The float is associated with oPC and stored in the variable sVar
float DLA_GetPersistFloat(object oPC, string sVar);

// Retrieve the string stored persistently using DLA_SetPersistentString
// The string is associated with oPC and stored in the variable sVar
string DLA_GetPersistString(object oPC, string sVar);

// Retrieve the object stored persistently using DLA_SetPersistentObject
// The object is associated with oPC and stored in the variable sVar
object DLA_GetPersistObject(object oPC, string sVar);

// Stores the integer iValue in the variable sVar associating it with oPC
void DLA_SetPersistInt(object oPC, string sVar, int iValue);

// Stores the float fValue in the variable sVar associating it with oPC
void DLA_SetPersistFloat(object oPC, string sVar, float fValue);

// Stores the string sValue in the variable sVar associating it with oPC
void DLA_SetPersistString(object oPC, string sVar, string sValue);

// Stores the object oValue in the variable sVar associating it with oPC
void DLA_SetPersistObject(object oPC, string sVar, object oValue);

///////////////////////////////////////////////
/////// End of headers declarations ///////////
///////////////////////////////////////////////

string DLA_GetID(object oPC)
{
    return (GetName(oPC) + GetPCPlayerName(oPC));
}

int DLA_GetPersistInt(object oPC, string sVar)
{
    return GetLocalInt(GetModule(), DLA_GetID(oPC) + sVar);
}

float DLA_GetPersistFloat(object oPC, string sVar)
{
    return GetLocalFloat(GetModule(), DLA_GetID(oPC) + sVar);
}

string DLA_GetPersistString(object oPC, string sVar)
{
    return GetLocalString(GetModule(), DLA_GetID(oPC) + sVar);
}

object DLA_GetPersistObject(object oPC, string sVar)
{
    return GetLocalObject(GetModule(), DLA_GetID(oPC) + sVar);
}

void DLA_SetPersistInt(object oPC, string sVar, int iValue)
{
    iValue == 0 ?
    DeleteLocalInt(GetModule(),(DLA_GetID(oPC) + sVar)) :
    SetLocalInt(GetModule(), (DLA_GetID(oPC) + sVar), iValue);
}

void DLA_SetPersistFloat(object oPC, string sVar, float fValue)
{
    fValue == 0.0 ?
    DeleteLocalString(GetModule(),(DLA_GetID(oPC) + sVar)) :
    SetLocalFloat(GetModule(), (DLA_GetID(oPC) + sVar), fValue);
}

void DLA_SetPersistString(object oPC, string sVar, string sValue)
{
    sValue == "" ?
    DeleteLocalString(GetModule(),(DLA_GetID(oPC) + sVar)) :
    SetLocalString(GetModule(), (DLA_GetID(oPC) + sVar), sValue);
}

void DLA_SetPersistObject(object oPC, string sVar, object oValue)
{
    oValue == OBJECT_INVALID ?
    DeleteLocalObject(GetModule(),(DLA_GetID(oPC) + sVar)) :
    SetLocalObject(GetModule(), (DLA_GetID(oPC) + sVar), oValue);
}
