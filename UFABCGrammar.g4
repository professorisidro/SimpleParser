grammar UFABCGrammar;

@header {
	import java.util.ArrayList;
	import java.util.HashMap;
	import io.compiler.types.*;
	import io.compiler.core.exceptions.*;
}

@members {
    private HashMap<String,Var> symbolTable = new HashMap<String, Var>();
    private ArrayList<Var> currentDecl = new ArrayList<Var>();
    private Types currentType;
    private Types leftType=null, rightType=null;
    
    public void updateType(){
    	for(Var v: currentDecl){
    	   v.setType(currentType);
    	   symbolTable.put(v.getId(), v);
    	}
    }
    public void exibirVar(){
        for (String id: symbolTable.keySet()){
        	System.out.println(symbolTable.get(id));
        }
    }
    
    public boolean isDeclared(String id){
    	return symbolTable.get(id) != null;
    }
}

programa	: 'programa' 
               declaravar+
               'inicio'
               comando+
               'fim'
               'fimprog'
			;
						
declaravar	: 'declare' { currentDecl.clear(); } 
               ID  { currentDecl.add(new Var(_input.LT(-1).getText()));}
               ( VIRG ID                
              		 { currentDecl.add(new Var(_input.LT(-1).getText()));}
               )*	 
               DP 
               (
               'number' {currentType = Types.NUMBER;}
               |
               'text' {currentType = Types.TEXT;}
               ) 
               
               { updateType(); } 
               PV
			;
			
comando     :  cmdAttrib
			|  cmdLeitura
			|  cmdEscrita
			;					
			
cmdAttrib   : ID { if (!isDeclared(_input.LT(-1).getText())) {
                       throw new UFABCSemanticException("Undeclared Variable: "+_input.LT(-1).getText());
                   }
                   symbolTable.get(_input.LT(-1).getText()).setInitialized(true);
                   leftType = symbolTable.get(_input.LT(-1).getText()).getType();
                 }
              OP_AT 
              expr 
              PV
              
              {
                 System.out.println("Left  Side Expression Type = "+leftType);
                 System.out.println("Right Side Expression Type = "+rightType);
                 if (leftType.getValue() < rightType.getValue()){
                    throw new UFABCSemanticException("Type Mismatchig on Assignment");
                 }
              }
			;			
			
cmdLeitura  : 'leia' AP 
               ID { if (!isDeclared(_input.LT(-1).getText())) {
                       throw new UFABCSemanticException("Undeclared Variable: "+_input.LT(-1).getText());
                    }
                    symbolTable.get(_input.LT(-1).getText()).setInitialized(true);
                  } 
               FP 
               PV 
			;
			
cmdEscrita  : 'escreva' AP ( termo ) FP PV { rightType = null;}
			;			

			
expr		:  termo exprl 			
			;
			
termo		: ID  { if (!isDeclared(_input.LT(-1).getText())) {
                       throw new UFABCSemanticException("Undeclared Variable: "+_input.LT(-1).getText());
                    }
                    if (!symbolTable.get(_input.LT(-1).getText()).isInitialized()){
                       throw new UFABCSemanticException("Variable "+_input.LT(-1).getText()+" has no value assigned");
                    }
                    if (rightType == null){
                       rightType = symbolTable.get(_input.LT(-1).getText()).getType();
                       //System.out.println("Encontrei pela 1a vez uma variavel = "+rightType);
                    }   
                    else{
                       if (symbolTable.get(_input.LT(-1).getText()).getType().getValue() > rightType.getValue()){
                          rightType = symbolTable.get(_input.LT(-1).getText()).getType();
                          //System.out.println("Ja havia tipo declarado e mudou para = "+rightType);
                          
                       }
                    }
                  }   
			| NUM    {  if (rightType == null) {
			 				rightType = Types.NUMBER;
			 				//System.out.println("Encontrei um numero pela 1a vez "+rightType);
			            }
			            else{
			                if (rightType.getValue() < Types.NUMBER.getValue()){			                    			                   
			                	rightType = Types.NUMBER;
			                	//System.out.println("Mudei o tipo para Number = "+rightType);
			                }
			            }
			         }
			| TEXTO  {  if (rightType == null) {
			 				rightType = Types.TEXT;
			 				//System.out.println("Encontrei pela 1a vez um texto ="+ rightType);
			            }
			            else{
			                if (rightType.getValue() < Types.TEXT.getValue()){			                    
			                	rightType = Types.TEXT;
			                	//System.out.println("Mudei o tipo para TEXT = "+rightType);
			                	
			                }
			            }
			         }
			;
			
exprl		: ( OP termo ) *
			;	
			
OP			: '+' | '-' | '*' | '/' 
			;	
			
OP_AT	    : ':='
		    ;			
			
ID			: [a-z] ( [a-z] | [A-Z] | [0-9] )*		
			;
			
NUM			: [0-9]+ ('.' [0-9]+ )?
			;			
			
VIRG		: ','
			;
						
PV			: ';'
            ;			
            
AP			: '('
			;            
						
FP			: ')'
			;
									
DP			: ':'
		    ;
		    
TEXTO       : '"' ( [a-z] | [A-Z] | [0-9] | ',' | '.' | ' ' | '-' )* '"'
			;		    
		    			
WS			: (' ' | '\n' | '\r' | '\t' ) -> skip
			;