/*/
============================================================================
AUTOR     :  Renato Morcerf
----------------------------------------------------------------------------
DATA      :  01/04/2021
----------------------------------------------------------------------------
DESCRICAO :  Cadastro de motivo de devolucao
----------------------------------------------------------------------------
PARTIDA   :  
============================================================================
/*/

#Include 'totvs.ch'
#INCLUDE "rwmake.ch"


User Function CADMOT


Private cCadastro := "Cadastro de Motivo de Devolução"
Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
             {"Visualizar","AxVisual",0,2} ,;
             {"Incluir","AxInclui",0,3} ,;
             {"Alterar","AxAltera",0,4} ,;
             {"Excluir","AxDeleta",0,5} }

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "SZF"

dbSelectArea("SZF")
dbSetOrder(1)

dbSelectArea(cString)
mBrowse( 6,1,22,75,cString)

Return

User Function CADMOV

Private cCadastro := "Movimento devolução"
Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
             {"Visualizar","AxVisual",0,2} ,;
             {"Incluir","",0,3} ,;
             {"Alterar","",0,4} ,;
             {"Excluir","",0,5} }

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "SZG"

dbSelectArea("SZG")
dbSetOrder(1)

dbSelectArea(cString)
mBrowse( 6,1,22,75,cString)

Return
