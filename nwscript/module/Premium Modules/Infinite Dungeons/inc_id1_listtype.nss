#include "inc_id1_flags"

int GetListMin(int nListType);
int GetListMax(int nListType);
int GetListValue(int nListType);
int GetListInfo(int nListType, int nCategory);

int GetListMin(int nListType)
{
    return GetListInfo(nListType, 1);
}

int GetListMax(int nListType)
{
    return GetListInfo(nListType, 2);
}

int GetListValue(int nListType)
{
    return GetListInfo(nListType, 3);
}

int GetListInfo(int nListType, int nCategory)
{
    int nMin;
    int nMax;
    int nValue;
    switch (nListType)
    {
        case 1:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 2:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 3:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 4:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 5:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 6:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 7:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 8:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 9:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 10:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 11:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 12:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 13:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 14:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 15:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 16:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 17:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 18:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 19:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 20:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 21:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
        case 22:
            nMin = 0;
            nMax = 0;
            nValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
            break;
    }

    if (nCategory == 1)
    {
        return nMin;
    } else if (nCategory == 2)
    {
        return nMax;
    } else
    {
        return nValue;
    }
}

