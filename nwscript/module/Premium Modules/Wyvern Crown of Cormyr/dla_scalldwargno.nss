//::///////////////////////////////////////////////
//:: FileName dla_scalldwargno
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//
//  Only shows the node if the PC is a dwarf or gnome
//
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 29th June 2006
//:://////////////////////////////////////////////

int StartingConditional()
{
 int nRace = GetRacialType(GetPCSpeaker());
 return nRace == RACIAL_TYPE_DWARF || nRace == RACIAL_TYPE_GNOME;
}
