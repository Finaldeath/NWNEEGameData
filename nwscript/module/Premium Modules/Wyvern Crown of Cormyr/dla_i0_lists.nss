////////////////////////////////////////////////////////////////////////////////
// dla_i0_lists - DLA Linked List Library Support Functions
// Original Scripter: Deva B. Winblood
// Last Modified By:  Deva B. Winblood   5/16/2006
//------------------------------------------------------------------------------
// These functions support creation and maintenance of double linked lists
////////////////////////////////////////////////////////////////////////////////


/////////////////////////////
// PROTOTYPES
/////////////////////////////

// FILE: dla_i0_lists           FUNCTION: DLA_LL_AddListNode()     [Linked List]
// This function will add a node to the specified list and will return the node
// number that it used.  If it returns 0 then the node was not created.
int DLA_LL_AddListNode(object oObject,string sListName);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_DeleteListNode()  [Linked List]
// This function will remove the specified node from the linked list and delete
// all variables associated with it.
void DLA_LL_DeleteListNode(object oObject,string sListName,int nNode);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_GetFirstNode()    [Linked List]
// This will return the first node for the specified list.  If it returns 0 then
// there are no nodes on this list.
int DLA_LL_GetFirstNode(object oObject,string sListName);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_GetNextNode()     [Linked List]
// This will return the next node for the specified list. If it returns o then
// there are no more nodes on this list.
int DLA_LL_GetNextNode(object oObject,string sListName);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_SetNodeInt()      [Linked List]
// This will set the specified sVar integer on the specified list and specified
// node to nValue
void DLA_LL_SetNodeInt(object oObject,string sListName,int nNode,string sVar,int nValue);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_GetNodeInt()      [Linked List]
// This will return the value of specified sVar integer on specified list and
// specified node.
int DLA_LL_GetNodeInt(object oObject,string sListName,int nNode,string sVar);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_SetNodeString()   [Linked List]
// This will set the specified sVar string on the specified list and specified
// node to sValue.
void DLA_LL_SetNodeString(object oObject,string sListName,int nNode,string sVar,string sValue);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_GetNodeString()   [Linked List]
// This will return the value of specified sVar string on the specified list and
// specified node.
string DLA_LL_GetNodeString(object oObject,string sListName,int nNode,string sVar);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_SetNodeObject()   [Linked List]
// This will set the specified sVar object on the specified list and specified
// node to oValue.
void DLA_LL_SetNodeObject(object oObject,string sListName,int nNode,string sVar,object oValue);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_GetNodeObject()   [Linked List]
// This will return the value of the specified sVar object on the specified list
// and specified node.
object DLA_LL_GetNodeObject(object oObject,string sListName,int nNode,string sVar);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_SetNodeFloat()    [Linked List]
// This will set the specified sVar float on the specified list and specified
// node to fValue.
void DLA_LL_SetNodeFloat(object oObject,string sListName,int nNode,string sVar,float fValue);

// FILE: dla_i0_lists           FUNCTION: DLA_LL_GetNodeInt()      [Linked List]
// This will return the value of the specified sVar float on the specified list
// and specified node.
float DLA_LL_GetNodeInt(object oObject,string sListName,int nNode,string sVar);


/////////////////////////////
// FUNCTIONS
/////////////////////////////

int DLA_LL_AddListNode(object oObject,string sListName)
{ // PURPOSE: To Add a new node to sListName list on oObject
  // list is structured as follows:
  // LL_listname_root = root of list
  // LL_listname_#_next = next list node
  // LL_listname_#_prev = prev list node
  // Variables are LL_listname_#_<t>var
  //        <t> n=int, s=string, o=object, f=float
  // LL_listname_#_var# = variable names (used for cleanup)
  // LL_listname_#_last = last variable #
  // LL_Listname_current = current node (used with get first/next)
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood   5/16/2006
  int nHead;
  int nN;
  if (GetIsObjectValid(oObject)&&GetStringLength(sListName)>0)
  { // valid parameters passed
    nHead=GetLocalInt(oObject,"LL_"+sListName+"_root");
    if (nHead>0)
    { // list exists
      nN=Random(9999)+1;
      while(GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nN)+"_prev")!=0)
      { // find a new node # that is acceptable
        nN++;
      } // find a new node # that is acceptable
      SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nN)+"_next",nHead);
      SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nN)+"_prev",-1);
      SetLocalInt(oObject,"LL_"+sListName+"_root",nN);
      return nN;
    } // list exists
    else
    { // new list
      SetLocalInt(oObject,"LL_"+sListName+"_1_prev",-1);
      SetLocalInt(oObject,"LL_"+sListName+"_root",1);
      return 1;
    } // new list
  } // valid parameters passed
  return 0;
} // DLA_LL_AddListNode()


void DLA_LL_DeleteListNode(object oObject,string sListName,int nNode)
{ // PURPOSE: This will delete a node and clean all variables defined on the
  // node.  See, DLA_LL_AddListNode for complete description of a list layout.
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood  5/16/2006
  int nHead;
  int nPrev;
  int nNext;
  int nN;
  string sS;
  string sL;
  if (GetIsObjectValid(oObject)&&GetStringLength(sListName)>0&&nNode>0)
  { // valid parameters passed
    nHead=GetLocalInt(oObject,"LL_"+sListName+"_root");
    if (nHead>0)
    { // list exists
      nPrev=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_prev");
      nNext=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_next");
      if (nNode==nHead)
      { // deleting head
        SetLocalInt(oObject,"LL_"+sListName+"_root",nNext);
        if (nNext>0)
        { // next exists
          SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNext)+"_prev",-1);
        } // next exists
      } // deleting head
      else
      { // deleting from inner
        if (nPrev>0)
        { // previous
          if (nNext>0)
          { // set prev to next
            SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nPrev)+"_next",nNext);
          } // set prev to next
        } // previous
        if (nNext>0)
        { // next
          if (nPrev!=0)
          { // set next to prev
            SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNext)+"_prev",nPrev);
          } // set next to prev
        } // next
      } // deleting from inner
      // clean out variables
      nN=1;
      sS=GetLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_var"+IntToString(nN));
      while(GetStringLength(sS)>0)
      { // delete variables
        sL=GetStringLeft(sS,1);
        if (sL=="n")
        { // integer
          DeleteLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_"+sS);
        } // integer
        else if (sL=="s")
        { // string
          DeleteLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_"+sS);
        } // string
        else if (sL=="o")
        { // object
          DeleteLocalObject(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_"+sS);
        } // object
        else if (sL=="f")
        { // float
          DeleteLocalFloat(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_"+sS);
        } // float
        DeleteLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_var"+IntToString(nN));
        nN++;
        sS=GetLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_var"+IntToString(nN));
      } // delete variables
      DeleteLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_prev");
      DeleteLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_next");
      DeleteLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last");
    } // list exists
  } // valid parameters passed
} // DLA_LL_DeleteListNode()


int DLA_LL_GetFirstNode(object oObject,string sListName)
{ // PURPOSE: Return the first node number
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   5/16/2006
  int nHead;
  if (GetIsObjectValid(oObject)&&GetStringLength(sListName)>0)
  { // valid parameters
    nHead=GetLocalInt(oObject,"LL_"+sListName+"_root");
    SetLocalInt(oObject,"LL_"+sListName+"_current",nHead);
    return nHead;
  } // valid parameters
  return 0;
} // DLA_LL_GetFirstNode()


int DLA_LL_GetNextNode(object oObject,string sListName)
{ // PURPOSE: Return the next node number
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   5/16/2006
  int nCurrent;
  if (GetIsObjectValid(oObject)&&GetStringLength(sListName)>0)
  { // valid parameters
    nCurrent=GetLocalInt(oObject,"LL_"+sListName+"_current");
    nCurrent=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nCurrent)+"_next");
    SetLocalInt(oObject,"LL_"+sListName+"_current",nCurrent);
    return nCurrent;
  } // valid parameters
  return 0;
} // DLA_LL_GetNextNode()


void DLA_LL_SetNodeInt(object oObject,string sListName,int nNode,string sVar,int nValue)
{ // PURPOSE: Add sVar variable to sListName and nNode
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   5/16/2006
  int nN;
  if (GetIsObjectValid(oObject)&&GetStringLength(sListName)>0&&nNode>0&&GetStringLength(sVar)>0)
  { // valid parameters passed
    if (GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_prev")!=0)
    { // node defined
      if (nValue!=0)
      { // define variable table
        nN=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_n"+sVar);
        if (nN==0)
        { // not defined
          nN=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last");
          nN++;
          SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last",nN);
          SetLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_var"+IntToString(nN),"n"+sVar);
        } // not defined
        SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_n"+sVar,nValue);
      } // define variable table
      else
      { // 0
        DeleteLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_n"+sVar);
      } // 0
    } // node defined
  } // valid parameters passed
} // DLA_LL_SetNodeInt()


int DLA_LL_GetNodeInt(object oObject,string sListName,int nNode,string sVar)
{ // PURPOSE: Return the value of sVar Variabloe on sListName and nNode
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood    5/16/2006
  return GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_n"+sVar);
} // DLA_LL_GetNodeInt()


void DLA_LL_SetNodeString(object oObject,string sListName,int nNode,string sVar,string sValue)
{ // PURPOSE: Add sVar variable to sListName and nNode
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   5/16/2006
  int nN;
  if (GetIsObjectValid(oObject)&&GetStringLength(sListName)>0&&nNode>0)
  { // valid parameters passed
    if (GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_prev")!=0)
    { // node defined
      if (GetStringLength(sValue)>0)
      { // define variable table
        nN=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_n"+sVar);
        if (nN==0)
        { // not defined
          nN=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last");
          nN++;
          SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last",nN);
          SetLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_var"+IntToString(nN),"s"+sVar);
        } // not defined
        SetLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_s"+sVar,sValue);
      } // define variable table
      else
      { // 0
        DeleteLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_s"+sVar);
      } // 0
    } // node defined
  } // valid parameters passed
} // DLA_LL_SetNodeString()


string DLA_LL_GetNodeString(object oObject,string sListName,int nNode,string sVar)
{ // PURPOSE: Return the value of sVar Variabloe on sListName and nNode
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood    5/16/2006
  return GetLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_s"+sVar);
} // DLA_LL_GetNodeString()


void DLA_LL_SetNodeObject(object oObject,string sListName,int nNode,string sVar,object oValue)
{ // PURPOSE: Add sVar variable to sListName and nNode
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   5/16/2006
  int nN;
  if (GetIsObjectValid(oObject)&&GetStringLength(sListName)>0&&nNode>0&&GetStringLength(sVar)>0)
  { // valid parameters passed
    if (GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_prev")!=0)
    { // node defined
      if (GetIsObjectValid(oValue))
      { // define variable table
        nN=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_n"+sVar);
        if (nN==0)
        { // not defined
          nN=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last");
          nN++;
          SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last",nN);
          SetLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_var"+IntToString(nN),"o"+sVar);
        } // not defined
        SetLocalObject(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_o"+sVar,oValue);
      } // define variable table
      else
      { // 0
        DeleteLocalObject(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_o"+sVar);
      } // 0
    } // node defined
  } // valid parameters passed
} // DLA_LL_SetNodeObject()


object DLA_LL_GetNodeObject(object oObject,string sListName,int nNode,string sVar)
{ // PURPOSE: Return the value of sVar Variabloe on sListName and nNode
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood    5/16/2006
  return GetLocalObject(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_o"+sVar);
} // DLA_LL_GetNodeObject()


void DLA_LL_SetNodeFloat(object oObject,string sListName,int nNode,string sVar,float fValue)
{ // PURPOSE: Add sVar variable to sListName and nNode
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   5/16/2006
  int nN;
  if (GetIsObjectValid(oObject)&&GetStringLength(sListName)>0&&nNode>0&&GetStringLength(sVar)>0)
  { // valid parameters passed
    if (GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_prev")!=0)
    { // node defined
      if (fValue!=0.0)
      { // define variable table
        nN=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_n"+sVar);
        if (nN==0)
        { // not defined
          nN=GetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last");
          nN++;
          SetLocalInt(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_last",nN);
          SetLocalString(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_var"+IntToString(nN),"f"+sVar);
        } // not defined
        SetLocalFloat(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_f"+sVar,fValue);
      } // define variable table
      else
      { // 0
        DeleteLocalFloat(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_f"+sVar);
      } // 0
    } // node defined
  } // valid parameters passed
} // DLA_LL_SetNodeFloat()


float DLA_LL_GetNodeFloat(object oObject,string sListName,int nNode,string sVar)
{ // PURPOSE: Return the value of sVar Variabloe on sListName and nNode
  // Original Scripter:  Deva B. Winblood
  // Last Modified By:   Deva B. Winblood    5/16/2006
  return GetLocalFloat(oObject,"LL_"+sListName+"_"+IntToString(nNode)+"_f"+sVar);
} // DLA_LL_GetNodeFloat()


//void main(){}
