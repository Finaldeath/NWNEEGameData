string MakeTextRed(string sText);
string MakeTextGreen(string sText);
string MakeTextYellow(string sText);
string MakeTextOrange(string sText);
string AddLineBreak(string sText);

string MakeTextRed(string sText)
{
    return "<cþ  >" + sText + "</c>";
}

string MakeTextGreen(string sText)
{
    return "<c þ >" + sText + "</c>";
}

string MakeTextYellow(string sText)
{
    return "<cþþ >" + sText + "</c>";
}

string MakeTextOrange(string sText)
{
    return "<cþd >" + sText + "</c>";
}

string AddLineBreak(string sText)
{
    return sText + "\n";
}

//void main(){}

